Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :shops, only: %i(index show)
end
