defmodule Medirepo do
  alias Medirepo.Hospitals.Create, as: HospitalCreate
  alias Medirepo.Hospitals.Delete, as: HospitalDelete
  alias Medirepo.Hospitals.Get, as: HospitalGet
  alias Medirepo.Hospitals.Update, as: HospitalUpdate

  defdelegate create_hospital(params), to: HospitalCreate, as: :call
  defdelegate get_hospital_by_id(id), to: HospitalGet, as: :by_id
  defdelegate get_hospital_by_email(params), to: HospitalGet, as: :by_email
  defdelegate get_hospitals, to: HospitalGet, as: :get_all
  defdelegate delete_hospital(id), to: HospitalDelete, as: :call
  defdelegate update_hospital(params), to: HospitalUpdate, as: :call
  defdelegate reset_password(id), to: HospitalUpdate, as: :reset_pass
end
