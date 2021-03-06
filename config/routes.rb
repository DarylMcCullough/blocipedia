Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis
  
  resources :wikis, only: [] do
     resources :collaborators, only: [:create, :destroy]
   end

  devise_for :users

  match 'users/:id/downgrade' => 'charges#downgrade', :via => [:post], :as => 'downgrade_user'
  
  post "charges/downgrade" => 'charges#downgrade'

  get "wikis/index"
  root 'wikis#index'
end
