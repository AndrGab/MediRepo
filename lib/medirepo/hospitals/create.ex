defmodule Medirepo.Hospitals.Create do
  alias Medirepo.{Error, Repo, Hospital}

  def call(params) do
    params
    |> Hospital.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Hospital{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
