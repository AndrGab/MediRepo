defmodule Medirepo.Repo do
  use Ecto.Repo,
    otp_app: :medirepo,
    adapter: Ecto.Adapters.Postgres
end
