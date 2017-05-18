class WikisController < ApplicationController
  def index
      @wikis = policy_scope(Wiki)
  end

    def show
        @wiki = Wiki.find(params[:id])
    end

    def new
        @wiki = Wiki.new
        authorize @wiki
    end
  
    def create
        @wiki = Wiki.new(wiki_params)
        @wiki.user = current_user
        authorize @wiki
        if @wiki.save!
            redirect_to @wiki, notice: "Wiki was saved successfully."
        else
            flash.now[:alert] = "Error creating wiki. Please try again."
            render :new
        end
    end

    def edit
        @wiki = Wiki.find(params[:id])
        authorize @wiki
    end
  
    def update
        @wiki = Wiki.find(params[:id])
        authorize @wiki
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
        authorize @wiki
 
        if @wiki.destroy
            flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the wiki."
            render :show
        end
    end
    
    def render_stuff
        renderer = Redcarpet::Render::HTML.new(render_options = {})
        markdown = Redcarpet::Markdown.new(renderer, extensions = {})
        markdown.render("This is *bongos*, indeed.")
    end
  
    private
 
    def wiki_params
        params.require(:wiki).permit(:title, :private, :body)
    end
end
