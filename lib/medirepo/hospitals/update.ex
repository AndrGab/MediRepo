defmodule Medirepo.Hospitals.Update do
  alias Medirepo.{Error, Repo, Hospital}

  def call(%{"id" => id} = params) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> do_update(hospital, params)
    end
  end

  defp do_update(hospital, params) do
    hospital
    |> Hospital.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Hospital{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
