Rails.application.routes.draw do

  get 'searches/form' => "searches#form", as: "search"
  root 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "homes/about" => "homes#about", as: "about"
  get '/mypage' => 'users#mypage'
  resources :posts do
    resources :comments, only: [:new, :create]
    resource :favorites, only: [:create, :destroy]
  end
  resources :comments, only: [:destroy]
  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
  end
  resources :searches

  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end
end
