Rails.application.routes.draw do
  # GraphQL
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  post "/graphql", to: "graphql#execute"

  # Devise
  devise_for :users,
             controllers: {
               sessions: "sessions",
               registrations: "registrations"
             }

  get "/member-data", to: "members#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
