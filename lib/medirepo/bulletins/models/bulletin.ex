defmodule Medirepo.Bulletins.Models.Bulletin do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.{Changeset, UUID}
  alias Medirepo.Hospitals.Models.Hospital

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @params [
    :name,
    :dt_birth,
    :general,
    :pressure,
    :conscience,
    :fever,
    :respiration,
    :diurese,
    :notes,
    :doctor,
    :dt_signature,
    :attendance,
    :cd_patient,
    :hospital_id
  ]

  @derive {Jason.Encoder, only: [:id] ++ @params}

  schema "bulletins" do
    field :name, :string
    field :dt_birth, :date
    field :general, :string
    field :pressure, :string
    field :conscience, :string
    field :fever, :string
    field :respiration, :string
    field :diurese, :string
    field :notes, :string
    field :doctor, :string
    field :dt_signature, :date
    field :attendance, :integer
    field :cd_patient, :integer

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
    |> validate_length(:name, min: 2)
    |> validate_length(:notes, min: 6)
    |> validate_number(:attendance, greater_than: 0)
    |> validate_number(:cd_patient, greater_than: 0)
    |> foreign_key_constraint(:hospital_id)
    |> validate_uuid()
  end

  defp validate_uuid(%Changeset{valid?: true, changes: %{hospital_id: id}} = changeset) do
    case UUID.cast(id) do
      :error -> add_error(changeset, :hospital_id, "Invalid UUID")
      _ -> changeset
    end
  end

  defp validate_uuid(changeset), do: changeset
end
