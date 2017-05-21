class CollaboratorsController < ApplicationController
    
    def create
        binding.pry
    end
    
    def destroy
        wiki = Wiki.find(params[:wiki_id])
        collaborator = wiki.collaborators.find(params[:id])
 
        if collaborator.destroy
            flash[:notice] = "User removed as a collaborator."
        else
            flash[:alert] = "Removal failed."
        end
        redirect_to wiki
   end
end
