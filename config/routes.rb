# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'home#index'
  get 'service', to: 'static#service'
  get 'contact', to: 'contact#new'
  post 'contact/confirm', to: 'contact#confirm'
  get 'contact/complete', to: 'contact#complete'
  post 'contact/complete', to: 'contact#create', as: 'create_contact'

  resources :keeplist, only: %i[index create destroy]
  resources :shops, only: %i[index]
  resources :reviews, only: %i[create destroy]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'

    get 'register', to: 'users/registrations#new'
    post 'register', to: 'users/registrations#create'
    delete 'register', to: 'users/registrations#destroy'

    get 'edit_user', to: 'users/registrations#edit'
    get 'change_password', to: 'users/registrations#edit'
  end
end
