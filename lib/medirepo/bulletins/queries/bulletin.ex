defmodule Medirepo.Bulletins.Queries.Bulletin do
  @moduledoc false

  import Ecto.Query

  alias Medirepo.Bulletins.Models.Bulletin

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
        bulletin.dt_birth ==
          ^vl_date and
          bulletin.attendance ==
            ^vl_password and
          bulletin.cd_patient == ^vl_login and
          bulletin.hospital_id == ^id,
      order_by: bulletin.inserted_at,
      preload: [:hospital]
    )
  end
end
