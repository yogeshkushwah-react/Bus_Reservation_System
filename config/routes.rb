Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "buses#index"

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                     }

  get "user/reservations" => "users#user_reservation"
  get "user/profile" => "users#show"

  resources :buses do
    get "search", on: :collection
    resources :reservations do
      get "check_availability", on: :collection
    end
  end

  get "busowner/profile" => "busowners#show"
  get "busowners" => "busowners#index"
  get "busowners/:id/buses" => "busowners#bus_owner_buses", as: "bus_owner_buses"
  get "busowner/reservations" => "users#user_reservation"

  scope "/admin" do
    get "sign_in", to: redirect("users/sign_in")
    get "profile", to: "admin#show"
    get "approve_bus/:id", to: "admin#approve_bus", as: "approve_bus"
    get "reject_bus/:id", to: "admin#reject_bus", as: "reject_bus"
    get "reservations" => "users#user_reservation"
  end
end
