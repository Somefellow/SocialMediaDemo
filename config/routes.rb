# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  # Backdoor admin area
  namespace :admin do
    resources :users
  end

  # Login / Registration
  get   '/login'     => 'sessions#new'
  post  '/login'     => 'sessions#create'
  get   '/logout'    => 'sessions#destroy'
  get   '/register'  => 'registrations#new'
  post  '/register'  => 'registrations#create'

  # User profile
  get '/user', to: 'user#show'
  get '/user/:id', to: 'user#show'

  # New post
  post '/post', to: 'post#create'
end
