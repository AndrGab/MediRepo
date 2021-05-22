defmodule Medirepo.Repo.Migrations.CreateHospitalsTable do
  use Ecto.Migration

  def change do
    create table(:hospitals) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :password_reset_token, :string
      add :password_sent_email_at, :naive_datetime

      timestamps()
    end

    create unique_index(:hospitals, [:email])
  end
end
