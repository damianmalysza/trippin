Rails.application.routes.draw do
  root to: "sessions#welcome"
  
  resources :users 
  resources :trips do
    resources :activities, except: :index
    resources :posts, except: :index do 
      resources :comments, except: [:index, :show]
    end
  end
  
  get '/', to: 'sessions#welcome'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/auth/github/callback', to: 'sessions#create'
  post '/join_trip', to: 'trips#join_trip'
  post '/leave_trip', to: 'trips#leave_trip'
end
