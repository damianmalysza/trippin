Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/edit'
  get 'comments/update'
  get 'comments/destroy'
  get 'posts/index'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  root to: "sessions#welcome"
  
  resources :users 
  resources :trips do
    resources :activities
    resources :posts do 
      resources :comments
    end
  end
  
  get '/', to: 'sessions#welcome'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/auth/github/callback', to: 'sessions#create'
end
