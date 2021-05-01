defmodule Medirepo.Hospitals.Get do
  alias Medirepo.{Error, Repo, Hospital}

  def by_id(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> {:ok, hospital}
    end
  end
end
