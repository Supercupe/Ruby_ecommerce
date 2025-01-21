Rails.application.routes.draw do
  devise_for :admins
  resource :admin, only: [:show], controller: :admin

  scope "(:locale)", locale: /en|es/ do
    get 'change_locale', to: 'locale#change_locale', as: :change_locale

    root "pages#home"
    get "pages/objednat"
    get 'about', to: 'pages#about', as: 'about'
    get "kontakt", to: 'pages#kontakt', as: 'kontakt'
    get "home", to: 'pages#home'
    get "index", to: 'produkty#index', as: 'cenik'
    get "contact", to: 'pages#contact', as: 'contact'
    
    resources :products, only: [:index]
    resources :products do
      scope module: :products do
        resources :purchases, only: [:create, :new] do
          get "success", on: :collection
        end
        resources :stripe_checkouts, only: [:create]
      end
    end
  end
end