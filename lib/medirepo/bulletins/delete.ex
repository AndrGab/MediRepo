defmodule Medirepo.Bulletins.Delete do
  alias Medirepo.{Bulletin, Error, Repo}

  def call(id) do
    case Repo.get(Bulletin, id) do
      nil -> {:error, Error.build_bulletin_not_found_error()}
      bulletin -> Repo.delete(bulletin)
    end
  end
end
