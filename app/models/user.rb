class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy


  after_initialize :init
  enum role: [:standard, :premium, :admin]
  
  def upgrade
    if self.standard?
      self.premium!
    end
  end
  
  def downgrade
    if self.premium?
      self.standard!
      self.wikis.each do |wiki|
        wiki.private = false
        wiki.save!
      end
    end
  end
  
  def init
    self.role ||= :standard
  end
  
  def collaborates_on
    collaborations.wikis
  end
end
