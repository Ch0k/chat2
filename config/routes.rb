Rails.application.routes.draw do
  #devise_for :users
  api_guard_routes for: 'users'
  namespace :api do
    namespace :v1 do
      resources :users do 
        get :me, on: :collection
      end
      resources :conversations do
        collection do
          get :inbox
          get :sentbox
          get :trash
        end
      end
      resources :messages
    end
  end
  root 'application#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
