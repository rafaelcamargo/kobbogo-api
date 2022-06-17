Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :destroy]
  resources :users, only: [:create]
  resources :auth, only: [:create]
end
