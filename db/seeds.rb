 require 'random_data'
 # Create Users
 5.times do
   user = User.new(
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
   user.confirm
   user.skip_confirmation!
   user.save!
 end
 users = User.all
 
 # create wikis
    10.times do
     Wiki.create!(
     user: users.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
     )
    end

  # Create an admin user
 admin = User.new(
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.confirm
 admin.skip_confirmation!
 admin.save!
 
 # Create a premium user
 premium = User.new(
     email: 'premium@example.com',
     password: 'helloworld',
     role: 'premium')
 premium.confirm
 premium.skip_confirmation!
 premium.save!


 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
 
