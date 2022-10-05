defmodule Medirepo.Repo.Migrations.ModifyBulletinsCollumns do
  use Ecto.Migration

  def change do
    rename table(:bulletins), :nome, to: :name
    rename table(:bulletins), :dt_nascimento, to: :dt_birth
    rename table(:bulletins), :geral, to: :general
    rename table(:bulletins), :pressao, to: :pressure
    rename table(:bulletins), :consciencia, to: :conscience
    rename table(:bulletins), :febre, to: :fever
    rename table(:bulletins), :respiracao, to: :respiration
    rename table(:bulletins), :obs, to: :notes
    rename table(:bulletins), :medico, to: :doctor
    rename table(:bulletins), :dt_assinatura, to: :dt_signature
    rename table(:bulletins), :atendimento, to: :attendance
    rename table(:bulletins), :cd_paciente, to: :cd_patient
  end
end
