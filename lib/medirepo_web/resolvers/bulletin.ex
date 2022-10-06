defmodule MedirepoWeb.Resolvers.Bulletin do
  alias Medirepo.Bulletins

  def get_bulletins(_parnet, _args, _resolution) do
    Bulletins.get_bulletins()
  end
end
