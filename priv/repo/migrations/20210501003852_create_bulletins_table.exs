defmodule Medirepo.Repo.Migrations.CreateBulletinsTable do
  use Ecto.Migration

  def change do
    create table(:bulletins) do
      add :nome, :string
      add :dt_nascimento, :date
      add :geral, :string
      add :pressao, :string
      add :consciencia, :string
      add :febre, :string
      add :respiracao, :string
      add :diurese, :string
      add :obs, :string
      add :medico, :string
      add :dt_assinatura, :date
      add :atendimento, :integer
      add :cd_paciente, :integer
      add :hospital_id, references(:hospitals, type: :binary_id)

      timestamps()
    end

  end
end
