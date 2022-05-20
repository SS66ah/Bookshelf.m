Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'top/index' => 'top#index'

  get 'books' => 'books#index'

  get 'books/new' => 'books#new'
  post 'books' => 'books#create'

  get 'books/:id' => 'books#show',as: 'book'

  patch 'books/:id' => 'books#update'
  delete 'books/:id' => 'books#destroy' 
  get 'books/:id/edit' => 'books#edit', as:'edit_book'

  root 'top#index'


end
