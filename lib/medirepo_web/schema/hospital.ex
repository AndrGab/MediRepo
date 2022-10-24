defmodule MedirepoWeb.Schema.Hospital do
  use Absinthe.Schema.Notation

  object :hospital do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  input_object :hospital_input do
    field :email, :string
    field :name, :string
    field :password, :string
    field :password_reset_token, :string
  end
end
