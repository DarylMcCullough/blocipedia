Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users

  get "wikis/index"
  root 'wikis#index'
end
