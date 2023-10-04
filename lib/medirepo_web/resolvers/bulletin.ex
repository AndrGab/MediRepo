defmodule MedirepoWeb.Resolvers.Bulletin do
  alias Medirepo.Bulletins

  def get_bulletins(_parnet, _args, _resolution) do
    case Bulletins.get_bulletins() do
      {:ok, result} -> {:ok, result}
      _error -> {:error, message: "Not found", details: "Empty database"}
    end
  end
end
