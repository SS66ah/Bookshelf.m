Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'top/index' => 'top#index'

  get 'books' => 'books#index'

  get 'books/new' => 'books#new'
  post 'books' => 'books#create'

  root 'top#index'


end
