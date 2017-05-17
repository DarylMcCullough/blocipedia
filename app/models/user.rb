class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :wikis, dependent: :destroy

  after_initialize :init
  enum role: [:standard, :premium, :admin]
  
  def upgrade
    if self.standard?
      self.premium!
    end
  end
  
  def downgrade
    if self.premium?
      puts "in downgrade"
      self.standard!
      self.wikis.each do |wiki|
        puts "wiki-id: #{wiki.id}"
        wiki.private = false
        wiki.save!
        puts "wiki.private: #{wiki.private}"

      end
      
    end
    
  end
  
  def init
    self.role ||= :standard
  end
end
