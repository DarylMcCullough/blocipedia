class WikisController < ApplicationController
  def index
      @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
      
    @wiki = Wiki.new(wiki_params)
    
    @wiki.user = current_user
      
    begin
         authorize @wiki
     rescue
        flash[:alert] = "You must be logged in to create a Wiki."
       redirect_to action: :index
       return
     end
     
     if @wiki.save!
       redirect_to @wiki, notice: "Wiki was saved successfully."
     else
       flash.now[:alert] = "Error creating wiki. Please try again."
       render :new
     end
   end

  def edit
      @wiki = Wiki.find(params[:id])
  end
  
  def update
     @wiki = Wiki.find(params[:id])
     begin
         authorize @wiki
     rescue
        flash[:alert] = "You must be logged in to edit this Wiki."
       redirect_to @wiki
       return
     end
     @wiki.assign_attributes(wiki_params)
 
     if @wiki.save
        flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "Error saving wiki. Please try again."
       render :edit
     end
  end
  
  def destroy
     @wiki = Wiki.find(params[:id])
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end
  
  private
 
   def wiki_params
     params.require(:wiki).permit(:title, :private, :body)
   end
end
