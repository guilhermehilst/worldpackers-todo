Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'tasks#index'

  devise_for :users

  resources :tasks do
    member do
      put :complete
    end
  end
end
