  # frozen_string_literal: true
Rails.application.routes.draw do
  # check all routes http://localhost:3000/rails/info/routes.
  # application routes
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # You can have the root of your site routed with "root"
  
  # -=-=-=-=-=-=-=-=-=-=-=-=- OPEN ROUTES -=-=-=-=-=-=-=-=-=-=-=-=-
  devise_for :users, controllers: {
    registrations: "custom_devise/registrations"
  }
  root to: 'pages#home'
  
  # -=-=-=-=-=-=-=-=-=-=-=-=- ADMIN ROUTES -=-=-=-=-=-=-=-=-=-=-=-=- 
  namespace :admin do
      resources  :users do
      collection do
        patch 'update_password'
        patch 'update_all_passwords'
      end
    end
    resources :tenants do
      member do
        patch 'change_current_tenant'
      end
      collection do
        patch 'disable_current_tenant'
      end
    end
    resources :dashboard, only: [:index]

    root to: "dashboard#index"
  end

  # -=-=-=-=-=-=-=-=-=-=-=-=- API ROUES -=-=-=-=-=-=-=-=-=-=-=-=-
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#login'
    end
  end
end
