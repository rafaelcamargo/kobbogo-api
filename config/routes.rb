Rails.application.routes.draw do
  resources :todos, only: [:index, :create]
  resources :users, only: [:create]
  resources :auth, only: [:create]
end
