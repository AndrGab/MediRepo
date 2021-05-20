defmodule Medirepo.Hospitals.Delete do
  alias Medirepo.{Error, Hospital, Repo}

  def call(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> delete_hospital(hospital)
    end
  end

  defp delete_hospital(param) do
    param
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.no_assoc_constraint(:bulletin)
    |> Repo.delete()
    |> handle_delete()
  end

  defp handle_delete({:ok, result}), do: {:ok, result}

  defp handle_delete({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
