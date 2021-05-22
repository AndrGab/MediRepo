defmodule Medirepo.Repo.Migrations.AddResetPasswordToHospitals do
  use Ecto.Migration

  def change do
    alter table(:hospitals) do
      add :password_reset_token, :string
      add :password_sent_email_at, :naive_datetime
    end
  end
end
