class CollaboratorsController < ApplicationController
    
    def create
        collaborators = params['collaborator']['user_id']
        wiki_id = params['wiki_id']
        wiki = Wiki.find_by_id(wiki_id)
        success = false
        collaborators.each do |id|
            user = User.find_by_id(id)
            if user.present?
                collaborator = Collaborator.new(user: user, wiki: wiki)
                authorize collaborator
                success = collaborator.save! || success
            end
        end
        if success
           flash[:notice] = "Collaborator(s) added successfully."
        else
            flash.now[:alert] = "Error adding collaborators. Please try again."
        end
        redirect_to wiki
    end
    
    def destroy
        wiki = Wiki.find(params[:wiki_id])
        collaborator = wiki.collaborators.find(params[:id])
        
        authorize collaborator
 
        if collaborator.destroy
            flash[:notice] = "User removed as a collaborator."
        else
            flash[:alert] = "Removal failed."
        end
        redirect_to wiki
   end
end
