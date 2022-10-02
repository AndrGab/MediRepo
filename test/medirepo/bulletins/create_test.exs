defmodule Medirepo.Bulletins.CreateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins
  alias Medirepo.Bulletins.Models.Bulletin
  alias Medirepo.Error
  alias Medirepo.Hospitals
  alias Medirepo.Hospitals.Models.Hospital

  import Medirepo.Factory

  describe "create_bulletin/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when all params are valid, returns the Bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      response = Bulletins.create_bulletin(params)

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
                notes: "PACIENTE ESTA REAGINDO BEM",
                doctor: "ANTONIO CARLOS PETRUS",
                dt_signature: _dt_assin,
                attendance: 99_999,
                cd_patient: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when there are invalid params, returns an error", %{hosp_id: hosp_id} do
      params =
        build(:bulletin_params, %{
          "name" => "T",
          "notes" => "123",
          "attendance" => 0,
          "cd_patient" => 0,
          "hospital_id" => hosp_id
        })

      response = Bulletins.create_bulletin(params)

      expected_response = %{
        attendance: ["must be greater than 0"],
        name: ["should be at least 2 character(s)"],
        notes: ["should be at least 6 character(s)"],
        cd_patient: ["must be greater than 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
