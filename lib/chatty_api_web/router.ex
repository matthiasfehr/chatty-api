defmodule ChattyApiWeb.Router do
  use ChattyApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChattyApiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChattyApiWeb do
  #   pipe_through :api
  # end

  forward "/graphql", Absinthe.Plug,
          schema: ChattyApi.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL,
          schema: ChattyApi.Schema
#          socket: ChattyApiWeb.UserSocket,
#          interface: :simple
end
