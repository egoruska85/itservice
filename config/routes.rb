Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  devise_for :users
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "main#index"
  resources :services
  resources :orders, only: [:new, :create, :update, :destroy, :show]
  resources :contacts
  # Defines the root path route ("/")
  # root "articles#index"
end
