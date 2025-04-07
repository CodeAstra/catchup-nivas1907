Rails.application.routes.draw do
  post "/create", to: "post#create"
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users
  resources :account, only: [ :show, :edit, :update ]
  resources :post, only: [ :index, :edit, :new, :destroy, :update ] do
    resources :like, only: [ :destroy, :create ]
  end
  resources :friend, only: [ :index, :show, :new, :create ]
  resources :friendrequests, only: [ :index, :update,  :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
