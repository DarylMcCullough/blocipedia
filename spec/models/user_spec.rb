require 'rails_helper'

RSpec.describe User, type: :model do
    
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user, private: true) }

    describe "initial user" do

     it "should have default role of 'standard'" do
       expect(user.role).to eq("standard")
     end
   end
   
    describe "upgrade changes standard user to premium" do

     it "should have role 'premium' after upgrade" do
         user.upgrade
        expect(user.role).to eq("premium")
     end
 end
     
     describe "downgrade premium user" do
         
     it "should have role 'standard' after downgrade" do
         user.upgrade
        expect(user.role).to eq("premium")
        user.downgrade
        expect(user.role).to eq("standard")
     end
     
     it "should make all wikis non-private" do
         wiki.user.premium!
         expect(wiki.private).to eq(true)
         wiki.user.downgrade
         wiki.reload
         expect(wiki.private).to eq(false)
     end
   end
   
   describe "invalid user" do
     let(:user_with_invalid_email) { build(:user, email: "") }
 
     it "should be an invalid user due to blank email" do
       expect(user_with_invalid_email).to_not be_valid
     end
 
   end

end
