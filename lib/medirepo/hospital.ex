defmodule Medirepo.Hospital do
  use Ecto.Schema
  import Ecto.Changeset

  alias Medirepo.Models.Bulletin

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :password, :name]
  @update_params [:email, :password, :name, :password_reset_token, :password_sent_email_at]
  @required_update [:email]

  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "hospitals" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_reset_token, :string
    field :password_sent_email_at, :naive_datetime

    has_many :bulletin, Bulletin

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params, @required_params)
  end

  def changeset(struct, params) do
    struct
    |> changes(params, @update_params, @required_update)
  end

  defp changes(struct, params, cast_fields, required_fields) do
    struct
    |> cast(params, cast_fields)
    |> validate_required(required_fields)
    |> validate_length(:name, min: 2)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
