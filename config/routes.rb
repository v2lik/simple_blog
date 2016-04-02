Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy] do
      post 'create_child', to: 'comments#create', on: :member
    end
  end
end
