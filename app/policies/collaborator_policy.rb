class CollaboratorPolicy < ApplicationPolicy
   attr_reader :user, :collaborator
   
    def initialize(user, collaborator)
        @user = user
        @collaborator = collaborator
    end
    
    def new? # user must be logged in to add a collaborator
        user.present?
    end
  
    def destroy? # only an admin or the owner can remove a collaborator
        user.present? && (user.admin? || user == collaborator.wiki.user) 
    end
  
    def create?
        if ! user.present? # user must be logged in to add a collaborator
            return false
        end
        
        if ! collaborator.wiki.private 
            return false # only private wikis have collaborators
        end
        
        # only admins and premium users can create private wikis
        (user.admin? || user == collaborator.wiki.user) 
    end
 
end