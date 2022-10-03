defmodule Medirepo.Hospitals.Db do
  alias Medirepo.Hospitals.Models.Hospital
  alias Medirepo.Hospitals.Queries.Hospital, as: HospitalQueries
  alias Medirepo.{Error, Repo}

  def insert(params) do
    params
    |> Hospital.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Hospital{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end

  def delete(id) do
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

  def get_by_id(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> {:ok, hospital}
    end
  end

  def get_by_email(%{"email" => email}) do
    query = HospitalQueries.by_email(email)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def get_by_email(_), do: {:error, Error.build(:bad_request, "Invalid 3 Params")}

  def get_by_id_and_reset_token(%{"id" => id, "reset_token" => token}) do
    query = HospitalQueries.by_id_and_reset_token(id, token)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def get_all do
    query = HospitalQueries.get_all_name_and_id()

    case Repo.all(query) do
      [] -> {:error, Error.build(:not_found, "Empty database")}
      hospital -> {:ok, hospital}
    end
  end

  defp handle_result([]), do: {:error, Error.build_hospital_not_found_error()}

  defp handle_result([result]), do: {:ok, result}

  def update(%{"id" => id} = params) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> do_update(hospital, params)
    end
  end

  def reset_pass(id) do
    params = %{
      "password_reset_token" => SecureRandom.urlsafe_base64(),
      "password_sent_email_at" => NaiveDateTime.utc_now()
    }

    Repo.get(Hospital, id)
    |> do_update(params)
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
