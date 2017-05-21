class Wiki < ActiveRecord::Base
    belongs_to :user
    has_many :collaborators, dependent: :destroy
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true

    def collaborating_users(current_user)
      possible_collaborators = User.all.where.not(id: current_user.id)
      # Does this wiki already have collaborators
      already_taken = self.collaborators.map{ |collaborator| User.find_by_id(collaborator.user_id)}
      # Subtract the possible collaborators from the ones already chosenx
      possible_collaborators - already_taken
    end
end
