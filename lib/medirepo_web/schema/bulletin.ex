defmodule MedirepoWeb.Schema.Bulletin do
  use Absinthe.Schema.Notation

  object :bulletin do
    field :id, :id
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
  end
end
