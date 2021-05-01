defmodule Medirepo do
  alias Medirepo.Bulletins.Create, as: BulletinCreate
  alias Medirepo.Bulletins.Get, as: BulletinGet
  alias Medirepo.Bulletins.Delete, as: BulletinDelete
  alias Medirepo.Bulletins.Update, as: BulletinUpdate

  alias Medirepo.Hospitals.Create, as: HospitalCreate
  alias Medirepo.Hospitals.Get, as: HospitalGet
  alias Medirepo.Hospitals.Delete, as: HospitalDelete
  alias Medirepo.Hospitals.Update, as: HospitalUpdate

  defdelegate create_bulletin(params), to: BulletinCreate, as: :call
  defdelegate get_bulletin_by_id(id), to: BulletinGet, as: :by_id
  defdelegate delete_bulletin(id), to: BulletinDelete, as: :call
  defdelegate update_bulletin(params), to: BulletinUpdate, as: :call

  defdelegate create_hospital(params), to: HospitalCreate, as: :call
  defdelegate get_hospital_by_id(id), to: HospitalGet, as: :by_id
  defdelegate delete_hospital(id), to: HospitalDelete, as: :call
  defdelegate update_hospital(params), to: HospitalUpdate, as: :call
end
