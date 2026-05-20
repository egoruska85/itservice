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

  resources :organizations do
    collection do
      post :create_company_details
    end
  end
  resources :privates
  resources :backoffices
  resources :company_details, only: [:destroy]
end
