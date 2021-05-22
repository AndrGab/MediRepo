defmodule Medirepo.Hospitals.Get do
  import Ecto.Query

  alias Medirepo.{Error, Hospital, Repo}

  def by_id(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> {:ok, hospital}
    end
  end

  def get_all do
    query =
      from(hospital in Hospital,
        select: [:id, :name]
      )

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      hospital -> {:ok, hospital}
    end
  end
end
