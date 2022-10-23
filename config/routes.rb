Rails.application.routes.draw do
  devise_for :users
 
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :doctors
      post '/auth/signup', to: 'users#create'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
