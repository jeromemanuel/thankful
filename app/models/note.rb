class Note < ActiveRecord::Base
  attr_accessible :content, :image, :tags, :user_id
  
  validates :content, :presence => true
  validates_length_of :content, :maximum => 200
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  # has_many :evaluations, class_name: "RSEvaluation", as: :source
  # 
  has_reputation :votes, source: :user, aggregated_by: :sum
  # 
  # def voted_for?(note)
  #   evaluations.where(target_type: note.class, target_id: note.id).present?
  # end
  def was_voted_by? user
      self.evaluations.find_by_source_id(user.id)
  end

  def self.most_voted
    find_with_reputation(:votes, :all, {:order => 'votes DESC'})
  end
  
end
