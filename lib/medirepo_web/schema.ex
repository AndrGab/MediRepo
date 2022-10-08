defmodule MedirepoWeb.Schema do
  use Absinthe.Schema
  import_types MedirepoWeb.Schema.Hospital
  import_types MedirepoWeb.Schema.Bulletin
  import_types Absinthe.Type.Custom

  alias MedirepoWeb.Resolvers

  query do
    @desc "Get all hospitals"
    field :hospitals, list_of(:hospital) do
      resolve &Resolvers.Hospital.get_hospitals/3
    end

    @desc "Get all bulletins"
    field :bulletins, list_of(:bulletin) do
      resolve &Resolvers.Bulletin.get_bulletins/3
    end
  end
end
