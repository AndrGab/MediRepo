defmodule Medirepo.Bulletins do
  @moduledoc false

  alias Medirepo.Bulletins.Db

  defdelegate create_bulletin(params), to: Db, as: :insert
  defdelegate get_bulletin_by_id(id), to: Db, as: :get_by_id
  defdelegate get_bulletins, to: Db, as: :get_all
  defdelegate get_all_bulletins(id), to: Db, as: :list_all_by
  defdelegate delete_bulletin(id), to: Db, as: :delete
  defdelegate update_bulletin(params), to: Db, as: :update
  defdelegate get_valid(params), to: Db, as: :get_valid
end
