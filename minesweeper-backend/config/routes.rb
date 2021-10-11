Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  devise_for :users,
             controllers: {
               sessions: "sessions",
               registrations: "registrations"
             }

  get "/member-data", to: "members#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
