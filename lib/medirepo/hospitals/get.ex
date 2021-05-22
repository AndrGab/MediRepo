defmodule Medirepo.Hospitals.Get do
  import Ecto.Query

  alias Medirepo.{Error, Hospital, Repo}

  def by_id(id) do
    case Repo.get(Hospital, id) do
      nil -> {:error, Error.build_hospital_not_found_error()}
      hospital -> {:ok, hospital}
    end
  end

  def by_email(%{"email" => email}) do
    query = from(hospital in Hospital, where: hospital.email == ^email)

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  def by_email(_), do: {:error, Error.build(:bad_request, "Invalid Params")}

  def by_id_and_reset_token(%{"id" => id, "reset_token" => token}) do
    query =
      from(hospital in Hospital,
        where: hospital.id == ^id and hospital.password_reset_token == ^token
      )

    result =
      query
      |> Repo.all()

    handle_result(result)
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

  defp handle_result([]), do: {:error, Error.build_hospital_not_found_error()}

  defp handle_result([result]), do: {:ok, result}
end
