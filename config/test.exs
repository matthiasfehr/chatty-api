use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chatty_api, ChattyApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chatty_api, ChattyApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatty_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
