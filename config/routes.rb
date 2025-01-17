Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  namespace :api do
    namespace :v1 do
      # routes for users
      resources :roles, only: [ :index, :show, :create, :update, :destroy ]

      resources :permissions, only: [ :index, :show, :create, :update, :destroy ]
      resources :users, only: [ :index, :show, :create, :update, :destroy ]

      resources :auth, only: [] do
        post :assign_roles, on: :collection
        post :login, on: :collection
        post :refresh_token, on: :collection
        post :logout, on: :collection
        post :assign_permissions, on: :collection
      end
      resources :artists, only: [ :index, :show, :create, :update, :destroy ]
      resources :songs, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
end
