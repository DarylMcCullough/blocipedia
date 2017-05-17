require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }
    
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
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(wikis_path)
      end
    end    
  end

end
