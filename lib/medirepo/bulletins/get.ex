defmodule Medirepo.Bulletins.Get do
  import Ecto.Query

  alias Medirepo.{Bulletin, Error, Repo}

  def by_id(id) do
    case Repo.get(Bulletin, id) do
      nil -> {:error, Error.build_bulletin_not_found_error()}
      bulletin -> {:ok, bulletin}
    end
  end

  def get_all do
    case Repo.all(Bulletin) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      bulletin -> {:ok, bulletin}
    end
  end

  def list_all_by(id) do
    query = from(bulletin in Bulletin, where: bulletin.hospital_id == ^id)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def list_all_by, do: {:error, Error.build(:bad_request, "Invalid Params")}

  defp handle_result([]), do: {:error, Error.build(:not_found, "Hospital ID not found")}

  defp handle_result(result), do: {:ok, result}
end
