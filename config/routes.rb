Rails.application.routes.draw do
  resources :todos, only: [:create]
end
