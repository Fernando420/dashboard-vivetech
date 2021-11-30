Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  # these routes are for showing users a login form, logging them in, and logging them out.
  resources :sessions do 
    collection do
      get '/login' => 'sessions#new'
      post '/login' => 'sessions#create'
      delete :logout
    end
  end

  resources :products do
    collection do
      get :add_variant
    end
  end

  resources :orders do
    collection do
      get :add_product
      get :add_variant
    end
  end
end
