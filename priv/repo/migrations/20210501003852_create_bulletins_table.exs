defmodule Medirepo.Repo.Migrations.CreateBulletinsTable do
  use Ecto.Migration

  def change do
    create table(:bulletins) do
      add :name, :string
      add :dt_birth, :date
      add :general, :string
      add :pressure, :string
      add :conscience, :string
      add :fever, :string
      add :respiration, :string
      add :diurese, :string
      add :notes, :string
      add :doctor, :string
      add :dt_signature, :date
      add :attendance, :integer
      add :cd_patient, :integer
      add :hospital_id, references(:hospitals, type: :binary_id)

      timestamps()
    end
  end
end
