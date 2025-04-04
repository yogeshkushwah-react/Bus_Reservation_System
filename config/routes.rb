Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "buses#index"

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }

  get "user/reservations" => "users#user_reservation"
  get "user/profile" => "users#show"

  resources :buses, constraints: { id: /[0-9]+/ } do
    get "search", on: :collection
    resources :reservations, constraints: { id: /[0-9]+/ } do
      get "check_availability", on: :collection
    end
  end

  get "busowner/profile" => "busowners#show"
  get "busowners" => "busowners#index"
  get "busowners/:id/buses" => "busowners#bus_owner_buses", as: "bus_owner_buses", constraints: { id: /[0-9]+/ }
  get "busowner/reservations" => "users#user_reservation"

  scope "/admin" do
    get "sign_in", to: redirect("users/sign_in")
    get "profile", to: "admin#show"
    get "approve_bus/:id", to: "admin#approve_bus", as: "approve_bus", constraints: { id: /[0-9]+/ }
    get "reject_bus/:id", to: "admin#reject_bus", as: "reject_bus", constraints: { id: /[0-9]+/ }
    get "reservations" => "users#user_reservation"
  end

  match "*unmatched", to: "application#not_found", via: :all, constraints: ->(req) {
                        !req.path.start_with?("/rails/active_storage")
                      }
end
