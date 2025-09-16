Rails.application.routes.draw do
  # GUEST PAGE
  root "guest#landing"
  get "/", to: "guest#landing", as: :guest_landing_page

  # AUTH USERS
  get "/signin", to: "auth#signin", as: :auth_signin_page
  get "/signup", to: "auth#signup", as: :auth_signup_page
  post "/signup", to: "auth#create", as: :auth_create_user
  post "/login", to: "auth#login", as: :auth_login
  delete "/logout", to: "auth#logout", as: :auth_logout

  # ADMIN USER PAGES
  get "admin/dashboard", as: :admin_dashboard_page
  namespace :admin do
    resources :events do
        collection do
          delete :bulk_delete
      end
    end
    resources :registrations do
      collection do
        delete :bulk_delete
        get :export # Add this line
      end
    end
  end

  # USER PAGES
  get "/dashboard", to: "user#dashboard", as: :user_dashboard_page
  # get "/new", to: "user#new", as: :user_new_events_page
  # post "/new", to: "user#create", as: :user_create_events_page
  resources :events do
    resources :registrations
  end
end
