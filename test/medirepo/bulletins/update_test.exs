defmodule Medirepo.Bulletins.UpdateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins
  alias Medirepo.Bulletins.Models.Bulletin
  alias Medirepo.Error
  alias Medirepo.Hospitals
  alias Medirepo.Hospitals.Models.Hospital
  import Medirepo.Factory

  describe "call/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Bulletins.create_bulletin(params)

      {:ok, id: id}
    end

    test "when all params are valid, returns the bulletin", %{id: id} do
      update_params = %{"id" => id, "name" => "Andre", "notes" => "PACIENTE"}

      response = Bulletins.update_bulletin(update_params)

      assert {:ok,
              %Bulletin{
                id: _id,
                name: "Andre",
                dt_birth: _dt_nasc,
                general: "ESTAVEL",
                pressure: "NORMAL",
                conscience: "CONSCIENTE",
                fever: "Ausente",
                respiration: "NORMAL",
                diurese: "NORMAL",
                notes: "PACIENTE",
                doctor: "ANTONIO CARLOS PETRUS",
                dt_signature: _dt_assin,
                attendance: 99_999,
                cd_patient: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when there are invalid params, returns an error", %{id: id} do
      update_params = %{"id" => id, "name" => "A", "notes" => "P"}

      response = Bulletins.update_bulletin(update_params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        notes: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when an inexistent id is sent, returns an error" do
      response =
        Bulletins.update_bulletin(%{
          "id" => "22d9e500-bacb-4e30-997a-239e5c2bb6b8",
          "name" => "Hospital de Teste"
        })

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end
end
