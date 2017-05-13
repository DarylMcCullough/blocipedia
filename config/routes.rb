Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users

  match 'users/:id/downgrade' => 'charges#downgrade', :via => [:post], :as => 'downgrade_user'
  get "wikis/index"
  root 'wikis#index'
end
