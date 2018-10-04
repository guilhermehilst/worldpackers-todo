Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :tasks do
    member do
      put :complete
    end
  end
end
