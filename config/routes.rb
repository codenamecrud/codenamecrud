Rails.application.routes.draw do

  devise_for :users
  namespace :admin do
    root 'home#index'
    resources :courses
    resources :sections
    resources :lessons
  end

  resources :courses, only: [:index, :show], path: '' do
    resources :lessons, only: :show, path: ''
  end

  root 'courses#index'

end
