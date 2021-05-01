defmodule Medirepo.Bulletins.Create do
  alias Medirepo.{Error, Repo, Bulletin}

  def call(params) do
    params
    |> Bulletin.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Bulletin{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
