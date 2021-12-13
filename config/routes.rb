# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :headhunters
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :headhunters, controllers: {
    sessions: 'headhunters/sessions',
    passwords: 'headhunters/passwords',
    registrations: 'headhunters/registrations'
  }
  root to: 'pages#home'
  resources :jobs, only: [:new, :create, :index, :show, :edit, :update] do
    post :enroll
    #resources :subscriptions
  end
  resources :profiles, only: [:new, :create, :edit, :show, :update]
  resources :comments
end
