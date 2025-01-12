Rails.application.routes.draw do
  resources :products do
    scope module: :products do
      resources :purchases, only: [:create, :new] do
        get "success", on: :collection
      end
      resources :stripe_checkouts, only: [:create]
    end
  end
end
