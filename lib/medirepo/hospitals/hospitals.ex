defmodule Medirepo.Hospitals do
  alias Medirepo.Hospitals.Db

  defdelegate create_hospital(params), to: Db, as: :insert
  defdelegate get_hospital_by_id(id), to: Db, as: :get_by_id
  defdelegate get_hospital_by_email(params), to: Db, as: :get_by_email
  defdelegate get_by_id_and_reset_token(params), to: Db, as: :get_by_id_and_reset_token
  defdelegate get_hospitals, to: Db, as: :get_all
  defdelegate delete_hospital(id), to: Db, as: :delete
  defdelegate update_hospital(params), to: Db, as: :update
  defdelegate reset_password(id), to: Db, as: :reset_pass
end
