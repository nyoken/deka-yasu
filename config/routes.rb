Rails.application.routes.draw do
  root 'home#index'
  resources :shops, only: %i(index show)
end
