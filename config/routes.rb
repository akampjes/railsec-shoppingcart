Rails.application.routes.draw do
  resources :orders

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
