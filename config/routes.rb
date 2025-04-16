Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }


  resources :account, only: [ :show, :edit, :update ] do
    collection do
      get "/cancel",            to: "account#cancel"
      patch "/privacyupdate",   to: "account#privacy"
    end
  end

  resources :posts, except: :show do
    collection do
      get "trendingposts",      to: "posts#trending"
      get "/cancelpost",        to: "posts#cancel"
    end
    resources :likes, only: [ :destroy, :create ]
  end

  resources :friendships, only: [ :index, :new, :create, :update ] do
    collection do
      get "/pending_requests",   to: "friendships#pending_requests"
      get "/search",            to: "friendships#search"
      get "/searchfriend",      to: "friendships#search2"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
