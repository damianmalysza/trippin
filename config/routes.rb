Rails.application.routes.draw do
  root to: "sessions#welcome"
  
  resources :users 
  resources :trips, except: [:index] do
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
