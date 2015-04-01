Rails.application.routes.draw do
  resources :courses, only: [:index, :show]

  root 'courses#index'

  namespace :admin do
    resources :courses
  end
end
