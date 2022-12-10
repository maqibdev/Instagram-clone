# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'posts#index'
  end

  root to: redirect('/users/sign_in')
  resources :users, only: [:show], id: /\d+/ do
    member do
      get 'follow_request'
    end
    collection do
      get 'search'
    end
    resources :followings, only: [:create], id: /\d+/
  end
  resources :posts, id: /\d+/ do
    resources :comments, except: [:index]
    resources :likes, only: [:create]
  end
  resources :stories, only: %i[new create destroy show], id: /\d+/
  resources :likes, only: [:destroy], id: /\d+/
  resources :followings, only: %i[update destroy], id: /\d+/ do
    member do
      delete 'decline_request'
    end
  end
  match '404', to: 'application#render_404', via: :all
end
