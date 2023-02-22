Rails.application.routes.draw do
  devise_for :users
  root to: "sounds#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sounds, only: %w[index new create destroy]
  resources :playlists, only: %w[index show new create destroy]
  resources :playlist_sounds, only: %w[create destroy]

  get 'user/:id/sounds', to: 'sounds#user_sounds', as: 'user_sounds'
end
