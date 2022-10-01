defmodule Medirepo.Bulletins.Queries.Bulletin do
  @moduledoc false

  import Ecto.Query

  alias Medirepo.Models.Bulletin

  def by_id(id) do
    from(bulletin in Bulletin, where: bulletin.hospital_id == ^id)
  end

  def get_valid(%{
        "login" => vl_login,
        "password" => vl_password,
        "dt_nasc" => vl_date,
        "id" => id
      }) do
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
  end
end
