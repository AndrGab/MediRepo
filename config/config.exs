# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :medirepo,
  ecto_repos: [Medirepo.Repo]

config :medirepo, Medirepo.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :medirepo, MedirepoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YutkeLt4skiFbOEbb5pj4oxfB6M/fbcgbd7xcNUHNs0XDPjKpyZn0X5meDTfrKL6",
  render_errors: [view: MedirepoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Medirepo.PubSub,
  live_view: [signing_salt: "Mj6THzQ+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
