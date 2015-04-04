Rails.application.routes.draw do
  resources :courses, only: [:index, :show], path: '' do
    resources :lessons, only: :show, path: ''
  end

  root 'courses#index'

  namespace :admin do
    root 'home#index'
    resources :courses
    resources :sections
    resources :lessons
  end
end
