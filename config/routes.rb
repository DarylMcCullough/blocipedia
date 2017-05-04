Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  get "wikis/index"
  root 'wikis#index'
end
