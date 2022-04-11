Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    get 'product_controller/all'
  end

  namespace :api do
    resources :products, only: %i[index create update show destroy] do
      collection do
        get 'get_by_desc', action: :get_by_desc
      end
    end
  end

  namespace :api do
    resources :comment_products, only: %i[index create update show destroy] do
    end
  end

end
