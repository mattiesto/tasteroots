Rails.application.routes.draw do
  # Routes for the Preference resource:
  # CREATE
  get "/preferences/new", :controller => "preferences", :action => "new"
  post "/create_preference", :controller => "preferences", :action => "create"

  # READ
  get "/preferences", :controller => "preferences", :action => "index"
  get "/preferences/:id", :controller => "preferences", :action => "show"

  # UPDATE
  get "/preferences/:id/edit", :controller => "preferences", :action => "edit"
  post "/update_preference/:id", :controller => "preferences", :action => "update"

  # DELETE
  get "/delete_preference/:id", :controller => "preferences", :action => "destroy"
  #------------------------------

  # Routes for the Route resource:
  # CREATE
  get "/routes/new", :controller => "routes", :action => "new"
  post "/create_route", :controller => "routes", :action => "create"

  # READ
  get "/routes", :controller => "routes", :action => "index"
  get "/routes/:id", :controller => "routes", :action => "show"

  # UPDATE
  get "/routes/:id/edit", :controller => "routes", :action => "edit"
  post "/update_route/:id", :controller => "routes", :action => "update"

  # DELETE
  get "/delete_route/:id", :controller => "routes", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
