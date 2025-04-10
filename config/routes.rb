Rails.application.routes.draw do
  get "trending/index"
  get "/search" , to: "friend#search"
  get "/searchfriend", to: "friend#search2"
  post "/create", to: "posts#create"
  patch "/privacyupdate", to: "account#privacy"
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users
  resources :account, only: [ :show, :edit, :update ]
  resources :posts, only: [ :index, :edit, :new, :destroy, :update ] do
    resources :like, only: [ :destroy, :create ]
  end
  resources :friend, only: [ :index, :show, :new, :create ]
  resources :friendrequests, only: [ :index, :update,  :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
