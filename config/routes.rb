Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "buses#index"

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                     }

  resources :buses do
    collection do
      get "search"
    end
    resources :reservations
  end
  get "admin/sign_in", to: redirect("users/sign_in")
  resources :admin
end
