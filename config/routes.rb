Rails.application.routes.draw do

  namespace :admin do
    root 'home#index'
  end

  resources :users, path: 'user', only: :show do
    get 'activity', on: :collection
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: :registrations }

  root 'pages#home'

  get 'pages/faq'
  get 'pages/about'
  get 'pages/contacts'
  get 'pages/contribute'
  get 'pages/thanks'
  get 'pages/home'
  get 'pages/curriculum'

  resources :courses, only: :show, path: '' do
    resources :lessons, only: :show, path: '' do
      post :toggle_check, on: :member
    end
  end


end
