Rails.application.routes.draw do
  get "trending/index"
  get "/search" , to: "friends#search"
  get "/searchfriend", to: "friends#search2"
  post "/create", to: "posts#create"
  get "/cancelpost", to: "posts#cancel"
  get "/cancelaccount", to: "account#cancel"
  patch "/privacyupdate", to: "account#privacy"
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :users
  resources :account, only: [ :show, :edit, :update ]
  resources :posts, only: [ :index, :edit, :new, :destroy, :update ] do
    resources :likes, only: [ :destroy, :create ]
  end
  resources :friends, only: [ :index, :show, :new, :create ]
  resources :friendrequests, only: [ :index, :update,  :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
