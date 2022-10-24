defmodule MedirepoWeb.Schema do
  use Absinthe.Schema
  import_types MedirepoWeb.Schema.Hospital
  import_types MedirepoWeb.Schema.Bulletin
  import_types Absinthe.Type.Custom

  alias MedirepoWeb.Resolvers.{Bulletin, Hospital}

  query do
    @desc "Get all hospitals"
    field :hospitals, list_of(:hospital) do
      resolve &Hospital.get_hospitals/3
    end

    @desc "List all bulletins from a hospital"
    field :bulletins, list_of(:bulletin) do
      resolve &Bulletin.get_bulletins/3
    end
  end

  mutation do
    field :create_hospital, :hospital do
      arg :input, non_null(:hospital_input)
      resolve &Hospital.create_hospital/3
    end
  end
end
