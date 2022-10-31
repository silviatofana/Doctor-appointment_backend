Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users
 
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users
      get '/patient/appointments', to: 'users#appointments'
      resources :doctors do
        resources :appointments
      end
      post '/auth/signup', to: 'users#create'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
