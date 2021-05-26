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

config :medirepo, MedirepoWeb.Auth.Guardian,
  issuer: "medirepo",
  secret_key: "yRVGMXDyZkdOn8fbeKtg6+F7v3Lc7s5AwQXlWBCDo7pT4iY7Z3TcuACUeGO3M/ZO"

config :medirepo, MedirepoWeb.Auth.Pipeline,
  module: MedirepoWeb.Auth.Guardian,
  error_handler: MedirepoWeb.Auth.ErrorHandler

config :medirepo, Medirepo.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailtrap.io",
  hostname: "smtp.mailtrap.io",
  port: 2525,
  username: Application.get_env(:medirepo, :smtp_username) || System.get_env("SMTP_USERNAME"),
  password: Application.get_env(:medirepo, :smtp_password) || System.get_env("SMTP_PASSWORD"),
  # can be `:always` or `:never`
  tls: :never,
  # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  allowed_tls_versions: ["tlsv1", "tlsv1.1", "tlsv1.2"],
  # can be `true`
  ssl: false,
  retries: 1,
  # can be `true`
  no_mx_lookups: false,
  auth: :if_available

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
