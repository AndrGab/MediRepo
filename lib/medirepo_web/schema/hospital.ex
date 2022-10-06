defmodule MedirepoWeb.Schema.Hospital do
  use Absinthe.Schema.Notation

  object :hospital do
    field :id, :id
    field :name, :string
    field :email, :string
  end
end
