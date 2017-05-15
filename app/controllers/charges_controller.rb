require 'amounts'
class ChargesController < ApplicationController
 def new
  if ! current_user.present?
    flash[:alert] = "You must be logged in to upgrade to a premium membership."
       redirect_to wikis_url
       return
  end
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: Amount.default
   }
 end

  def show
  end
  
  def upgrade
    if current_user.present?
      current_user.upgrade
     end

   flash[:notice] = "You are now a Premium member!"
     redirect_to :wikis
  end
  
  def downgrade
   puts "in downgrade"
    if current_user.present?
      current_user.downgrade
      puts "in downgrade, current_user.role: #{current_user.role}"
      puts "in downgrade, current_user.email: #{current_user.email}"
     end

   flash[:notice] = "Sorry you didn't appreciate your premium membership. You can always sign up again."
     redirect_to :wikis
  end
  
  def create
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: Amount.default,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
   )
   
  upgrade
 
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
 end
end
