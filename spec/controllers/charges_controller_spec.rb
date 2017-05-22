require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  
  let(:my_user) { create(:user, email: "my_user@mycompany.com") }

  describe "GET #new" do
    it "returns http success" do
      my_user.confirm
      sign_in my_user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST downgrade" do
       it "downgrades the user to standard" do
         user = my_user
          user.confirm
          sign_in user
          user.premium!
          post :downgrade
          user.reload
          expect(user.role).to eq("standard")
        end
   end

end
