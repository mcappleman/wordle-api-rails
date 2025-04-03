Rails.application.routes.draw do
  resources :answers
  resources :users
  resources :guesses
  resources :boards
  resources :wordles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post "login" => "authentication#authenticate"

  get "me" => "me#index"
  patch "me" => "me#update"
  put "me" => "me#update"
  delete "me" => "me#destroy"
end
