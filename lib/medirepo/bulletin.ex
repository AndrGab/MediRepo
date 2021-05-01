defmodule Medirepo.Bulletin do
  use Ecto.Schema
  import Ecto.Changeset

  alias Medirepo.Hospital

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @params [
    :nome,
    :dt_nascimento,
    :geral,
    :pressao,
    :consciencia,
    :febre,
    :respiracao,
    :diurese,
    :obs,
    :medico,
    :dt_assinatura,
    :atendimento,
    :cd_paciente,
    :hospital_id
  ]

  @derive {Jason.Encoder, only: [:id] ++ @params}

  schema "bulletins" do
    field :nome, :string
    field :dt_nascimento, :date
    field :geral, :string
    field :pressao, :string
    field :consciencia, :string
    field :febre, :string
    field :respiracao, :string
    field :diurese, :string
    field :obs, :string
    field :medico, :string
    field :dt_assinatura, :date
    field :atendimento, :integer
    field :cd_paciente, :integer

    belongs_to :hospital, Hospital

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @params)
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @params)
  end

  defp changes(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:nome, min: 2)
    |> validate_length(:obs, min: 6)
    |> validate_number(:atendimento, greater_than: 0)
    |> validate_number(:cd_paciente, greater_than: 0)
    |> foreign_key_constraint(:hospital_id)
  end
end
