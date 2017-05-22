require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
    let(:owner) { create(:user) }
    let(:my_wiki) { create(:wiki, user: owner, private: true) }
    let(:colleague) { create(:user) }
    let(:other) { create(:user) }
    
    before do

    end
    
     describe "POST create" do
      it "fails if the user is not an owner" do
        other.confirm
        sign_in other
        n = Collaborator.count
        post :create, wiki_id: my_wiki.id, collaborator: {user_id: [colleague.id], wiki_id: my_wiki.id}
        n1 = Collaborator.count
        expect(response).to redirect_to wikis_path
        expect(n1).to eq(n)
      end

      it "succeeds if the user is the owner" do
        owner.confirm
        sign_in owner
        n = Collaborator.count
        post :create, wiki_id: my_wiki.id, collaborator: {user_id: [colleague.id], wiki_id: my_wiki.id}
        n1 = Collaborator.count
        expect(n1).to eq(n+1)
      end
      
      it "adds to the collaborator list for the wiki" do
        owner.confirm
        sign_in owner
        post :create, wiki_id: my_wiki.id, collaborator: {user_id: [colleague.id], wiki_id: my_wiki.id}
        collaborator = Collaborator.last
        expect(collaborator.user).to eq(colleague)
        expect(collaborator.wiki).to eq(my_wiki)
      end

    end

end
