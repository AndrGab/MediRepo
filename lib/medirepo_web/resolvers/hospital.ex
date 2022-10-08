defmodule MedirepoWeb.Resolvers.Hospital do
  alias Medirepo.Hospitals

  def get_hospitals(_parent, _args, _resolution) do
    Hospitals.get_hospitals()
  end
end
