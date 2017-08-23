# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chatty_api,
  ecto_repos: [ChattyApi.Repo]

# Configures the endpoint
config :chatty_api, ChattyApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8OUfhgdBGPOR+DNL8nLY8B8/oKrdKNtdjBdwkFYoSTqmd6FkAgvT59eTwTPoZInY",
  render_errors: [view: ChattyApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChattyApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
