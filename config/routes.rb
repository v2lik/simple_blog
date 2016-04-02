Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy] do
      post 'create_child', to: 'comments#create', on: :member
    end
  end

  resources :users, except: :index

  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout
  resources :sessions, only: :create
end
