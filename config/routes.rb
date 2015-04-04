Rails.application.routes.draw do
  resources :courses, only: [:index, :show]

  root 'courses#index'

  namespace :admin do
    root 'home#index'
    resources :courses
    resources :sections
  end
end
