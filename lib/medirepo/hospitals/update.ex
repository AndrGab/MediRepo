defmodule Medirepo.Hospitals.Update do
  alias Medirepo.{Error, Hospital, Repo}

  def call(%{"id" => id} = params) do
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
