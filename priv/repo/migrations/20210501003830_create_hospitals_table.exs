defmodule Medirepo.Repo.Migrations.CreateHospitalsTable do
  use Ecto.Migration

  def change do
    create table(:hospitals) do
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end
    create unique_index(:hospitals, [:email])
  end
end
