Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: { sessions: "api/users/sessions", registrations: "api/users/registrations" }

  if Rails.env.development?
    match '/stubs/*path', to: 'stubs#show', via: :get
  end

  root 'pages#index'

  namespace :api, defaults: { format: :json } do
    resources :products
    resources :sliders
    resources :catalogs
    resources :categories
    resources :sub_products
    resources :pictures
    resources :payment_methods
    resources :filter_groups
    resources :filter_values
    resources :orders
    resources :users
    resources :top_sliders
    scope :import, defaults: { format: :json} do
      post :products, to: "import#products"
      post :sub_products, to: "import#sub_products"
    end
    scope :export, defaults: { format: :json} do
      post :products, to: "export#products"
      post :sub_products, to: "export#sub_products"
    end
  end


end
