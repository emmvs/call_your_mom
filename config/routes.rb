Rails.application.routes.draw do
  devise_for :users

  # This constraints block ensures that authenticated users are directed to the dashboard page as the root,
  # while unauthenticated users are routed to the home page - The `warden` middleware checks for a signed-in user 🕵🏼‍♀️
  constraints ->(request) { request.env['warden'].user } do
    root 'pages#dashboard', as: :authenticated_root
  end
  root "pages#home"
end
