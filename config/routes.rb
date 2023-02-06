Rails.application.routes.draw do
  devise_for :users
  root to: "sounds#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sounds, only: %w[index new create destroy]
end
