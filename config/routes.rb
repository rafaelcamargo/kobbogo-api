Rails.application.routes.draw do
  root to: 'root#index'
  resources :todos, only: %i[index create destroy]
  resources :users, only: [:create]
  resources :auth, only: [:create]
end
