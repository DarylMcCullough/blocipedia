class Wiki < ActiveRecord::Base
    belongs_to :user
    has_many :collaborators, dependent: :destroy
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true

    def collaborating_users
        collaborators.users
    end
    
    def collaborating_user_ids
        collaborating_users.map { |user| user.id }
    end
end
