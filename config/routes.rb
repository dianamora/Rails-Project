Rails.application.routes.draw do
  root "sessions#home"
  #custom routes go first, because if not /:id will get read first and raise an error
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  match '/auth/:google_oauth2/callback' => 'sessions#omniauth', via: [:get, :post]
  get '/topreviewer' => 'users#toprevie'
 
  

  #login route
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  #logout route
  delete '/logout' => 'sessions#destroy'

  resources :comments
  
  resources :users do #NESTED ROUTES
    resources :reviews, only: [ :new,:create,:index, :reviews ]
  end
  
  resources :reviews do
    resources :comments, only: [:new,:create,:index]
  end
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

#WE ONLY NEST A ROUTE IF WE NEED IT NESTED/shallow routing/in these routes it is not crucial to know the id
