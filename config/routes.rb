Rails.application.routes.draw do
  get 'sections/show'

  resources :courses, only: [:index, :show]

  root 'courses#index'

  namespace :admin do
    root 'home#index'
    resources :courses
  end
end
