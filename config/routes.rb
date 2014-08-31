Rails.application.routes.draw do
  root to: 'images#index'
  resources :images, only: [:create, :index, :new, :show]
end
