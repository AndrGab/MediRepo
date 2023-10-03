import Config

config :medirepo,
  ecto_repos: [Medirepo.Repo]

config :medirepo, Medirepo.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :cors_plug,
  send_preflight_response?: true

config :medirepo, MedirepoWeb.Auth.Guardian,
  issuer: "medirepo",
  secret_key: "yRVGMXDyZkdOn8fbeKtg6+F7v3Lc7s5AwQXlWBCDo7pT4iY7Z3TcuACUeGO3M/ZO"

config :medirepo, MedirepoWeb.Auth.Pipeline,
  module: MedirepoWeb.Auth.Guardian,
  error_handler: MedirepoWeb.Auth.ErrorHandler

config :medirepo, Medirepo.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.umbler.com",
  hostname: "smtp.umbler.com",
  port: 587,
  username: Application.get_env(:medirepo, :smtp_username) || System.get_env("SMTP_USERNAME"),
  password: Application.get_env(:medirepo, :smtp_password) || System.get_env("SMTP_PASSWORD"),
  tls: :never,
  allowed_tls_versions: ["tlsv1", "tlsv1.1", "tlsv1.2"],
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :always

config :medirepo, Medirepo.Mailer, adapter: Bamboo.LocalAdapter

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

config :medirepo, email_address: System.get_env("EMAIL_ADDRESS", "test@example.com")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
