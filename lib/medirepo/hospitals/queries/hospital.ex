defmodule Medirepo.Hospitals.Queries.Hospital do
  @moduledoc false

  import Ecto.Query

  alias Medirepo.Hospitals.Models.Hospital

  def by_email(email) do
    from(hospital in Hospital, where: hospital.email == ^email)
  end

  def by_id_and_reset_token(id, token) do
    from(hospital in Hospital,
      where: hospital.id == ^id and hospital.password_reset_token == ^token
    )
  end

  def get_all_name_and_id do
    from(hospital in Hospital,
      select: [:id, :name]
    )
  end
end
