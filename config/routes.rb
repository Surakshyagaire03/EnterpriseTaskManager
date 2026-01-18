Rails.application.routes.draw do
  root "dashboard#index"

  devise_for :users

  resources :tasks do
    member do
      patch :mark_complete
    end
  end

  namespace :admin do
    resources :users
  end

  get "/dashboard", to: "dashboard#index"
end
