Rails.application.routes.draw do
  root to: "sessions#welcome"
  
  resources :users
  get '/', to: 'sessions#welcome'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
end
