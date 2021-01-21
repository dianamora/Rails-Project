Rails.application.routes.draw do
  #custom routes go first, because if not /:id will get read first and raise an error
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :comments
  resources :users
  resources :reviews
  # resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
