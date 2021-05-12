defmodule Medirepo.Bulletins.GetValid do
  import Ecto.Query

  alias Medirepo.{Error, Repo, Bulletin}

  def call(%{
        "login" => vl_login,
        "password" => vl_password,
        "dt_nasc" => vl_date,
        "id" => id
      }) do
    query =
      from(bulletin in Bulletin,
        where:
          bulletin.dt_nascimento ==
            ^vl_date and
            bulletin.atendimento ==
              ^vl_password and
            bulletin.cd_paciente == ^vl_login and
            bulletin.hospital_id == ^id,
        order_by: bulletin.inserted_at,
        preload: [:hospital]
      )

    result =
      query
      |> Repo.all()

    handle_result(result)
  end

  defp handle_result([]), do: {:error, Error.build(:not_found, "Bulletin not found")}

  defp handle_result([result | _tail]), do: {:ok, result}
end
