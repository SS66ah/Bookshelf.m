Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'top/index' => 'top#index'

  root 'books#index'
  
  resources :books do
    resources :comments, only: [:create]
    resources :rentals, only: [:create, :update]
    resource :isbns
  end


end
