class Wiki < ActiveRecord::Base
    belongs_to :user
    has_many :collaborators, dependent: :destroy
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true
    
    def collaborating_users
      self.collaborators.map { |collaborator| collaborator.user }
    end

    def possible_collaborators(current_user)
      possible_collaborators1 = User.all.where.not(id: current_user.id)
      # Subtract the possible collaborators from the ones already chosenx
      possible_collaborators1 - collaborating_users
    end
end
