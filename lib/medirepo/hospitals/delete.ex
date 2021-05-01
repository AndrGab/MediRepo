defmodule Medirepo.Hospitals.Delete do
  alias Medirepo.{Error, Repo, Hospital}

  def call(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> Repo.delete(hospital)
    end
  end
end
