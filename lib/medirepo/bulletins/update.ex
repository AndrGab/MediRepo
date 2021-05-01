defmodule Medirepo.Bulletins.Update do
  alias Medirepo.{Error, Repo, Bulletin}

  def call(%{"id" => id} = params) do
    case Repo.get(Bulletin, id) do
      nil -> {:error, Error.build_bulletin_not_found_error()}
      bulletin -> do_update(bulletin, params)
    end
  end

  defp do_update(bulletin, params) do
    bulletin
    |> Bulletin.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Bulletin{}} = result), do: result

  defp handle_update({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
