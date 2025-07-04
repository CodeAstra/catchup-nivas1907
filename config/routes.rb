Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :account, only: [ :show, :edit, :update ] do
    collection do
      get :cancel
      patch :privacy
    end
  end

  resources :posts, except: :show do
    collection do
      get :cancel
      get :my_posts
      get :onelayer
      post :daily_digest
    end
    resources :likes, only: [ :destroy, :create ]
  end

  resources :friendships, only: [ :index, :new, :create, :update ] do
    collection do
      get :pending_requests
      get :rejected_requests
      delete :cancel_request
      get :search
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"
end
