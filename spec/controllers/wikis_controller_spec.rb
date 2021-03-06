require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }
  let(:other_wiki) { create(:wiki, user: other_user, private: true) }

    
  context "member user doing CRUD on a wiki" do
    before do
      my_user.confirm
      sign_in my_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end
 
      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
      
      it "fails for a private wiki if not a collaborator" do
        get :show, {id: other_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end
    
    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end

    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "initializes @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end
    
    describe "POST create" do
      it "increases the number of Wikis by 1" do
        expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph} }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Wiki.last
      end
    end
    
    describe "DELETE destroy" do

      it "fails to delete the wiki when non-admin is logged in" do
        delete :destroy, {id: my_wiki.id}
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 1
      end

      it "redirects to wikis index" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
    
  end
  
  context "admin doing CRUD on wiki" do
    before do
        my_user.confirm
        my_user.admin!
        sign_in my_user
        my_wiki
    end

    describe "DELETE destroy" do

      it "deletes the wiki" do
        delete :destroy, {id: my_wiki.id}
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
  end
  
  context "user not logged in doing CRUD on a wiki" do

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, {id: my_wiki.id}
        expect(response).to redirect_to(wikis_path)
      end
    end
    
    
    describe "GET new" do
      it "returns http redirect" do
        get :new, wiki_id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
    
    
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(wikis_path)
      end
    end    
  end

end
