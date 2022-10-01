defmodule Medirepo.Bulletins.Db do
  @moduledoc false

  alias Medirepo.{Error, Repo}
  alias Medirepo.Models.Bulletin
  alias Medirepo.Bulletins.Queries.Bulletin, as: BulletinQuery

  def insert(params) do
    params
    |> Bulletin.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Bulletin{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end

  def delete(id) do
    case Repo.get(Bulletin, id) do
      nil -> {:error, Error.build_bulletin_not_found_error()}
      bulletin -> Repo.delete(bulletin)
    end
  end

  def get_by_id(id) do
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
    query = BulletinQuery.by_id(id)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def list_all_by, do: {:error, Error.build(:bad_request, "Invalid Params")}

  defp handle_result([]), do: {:error, Error.build(:not_found, "Hospital ID not found")}

  defp handle_result(result), do: {:ok, result}

  def get_valid(
        %{
          "login" => _vl_login,
          "password" => _vl_password,
          "dt_nasc" => _vl_date,
          "id" => _id
        } = params
      ) do
    query = BulletinQuery.get_valid(params)

    result =
      query
      |> Repo.all()

    handle_get_valid(result)
  end

  defp handle_get_valid([]), do: {:error, Error.build_bulletin_not_found_error()}

  defp handle_get_valid([result | _tail]), do: {:ok, result}

  def update(%{"id" => id} = params) do
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
