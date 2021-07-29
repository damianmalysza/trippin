Rails.application.routes.draw do
  resources :users
  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout'
end
