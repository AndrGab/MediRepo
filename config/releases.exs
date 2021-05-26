import Config

config :medirepo, MedirepoWeb.Endpoint,
  server: true,
  http: [port: {:system, "PORT"}],
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443]

config :medirepo,
  smtp_password: System.get_env("SMTP_PASSWORD")

config :medirepo,
  smtp_username: System.get_env("SMTP_USERNAME")
