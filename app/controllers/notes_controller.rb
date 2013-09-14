class NotesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :about]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.order(:created_at).page(params[:page]).per(5)
    # @notes = Note.all
    @user = User.find_by_id(params[:id])
    @note = Note.new
    @note.user = current_user
    
    @popular_notes = Note.page(params[:page]).per(5)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end
  
  def about 
    
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @user = User.find_by_id(params[:id])
    @note = Note.find(params[:id])
   
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end
  
  def user_profile
    @user = User.find_by_id(params[:id])
    @user_notes = Note.find_all_by_user_id(params[:id])
    @count_user_notes = Note.count(:all, :conditions => {:user_id => params[:id]})
    @note = Note.new
    @note.user = current_user
    
    @influence_score = current_user.reputation_for(:votes).to_i + @count_user_notes.to_i
    
  end


  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new
    @note.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])
    @note.user = current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end



  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to user_profile_path }
      format.json { head :no_content }
    end
  end
  
  def vote
    value = params[:type] == "love it!" ? 1 : -1
    @note = Note.find(params[:id])
    @note.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end
  

  
  
  
  
  
end
