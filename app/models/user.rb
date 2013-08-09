class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  
  validates_presence_of :name
  
  has_many :notes
  
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  
  has_reputation :votes, source: {reputation: :votes, of: :notes}, aggregated_by: :sum
  
  # def voted_for?(note)
  #   evaluations.where(target_type: note.class, target_id: note.id).exists?
  # end
  


  
end
