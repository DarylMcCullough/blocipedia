require 'rails_helper'

RSpec.describe User, type: :model do
    
    let(:user) { create(:user) }

    describe "initial user" do

     it "should have default role of 'standard'" do
       expect(user.role).to eq("standard")
     end
   end
   
   describe "invalid user" do
     let(:user_with_invalid_email) { build(:user, email: "") }
 
     it "should be an invalid user due to blank email" do
       expect(user_with_invalid_email).to_not be_valid
     end
 
   end

end
