Rails.application.routes.draw do
  root 'customers#index'
  devise_for :users
  resources :customers
end
