defmodule Medirepo.Bulletins.CreateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins
  alias Medirepo.Models.Bulletin
  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "create_bulletin/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = HospCreate.call(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when all params are valid, returns the Bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      response = Bulletins.create_bulletin(params)

      assert {:ok,
              %Bulletin{
                id: _id,
                nome: "Andre",
                dt_nascimento: _dt_nasc,
                geral: "ESTAVEL",
                pressao: "NORMAL",
                consciencia: "CONSCIENTE",
                febre: "Ausente",
                respiracao: "NORMAL",
                diurese: "NORMAL",
                obs: "PACIENTE ESTA REAGINDO BEM",
                medico: "ANTONIO CARLOS PETRUS",
                dt_assinatura: _dt_assin,
                atendimento: 99_999,
                cd_paciente: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when there are invalid params, returns an error", %{hosp_id: hosp_id} do
      params =
        build(:bulletin_params, %{
          "nome" => "T",
          "obs" => "123",
          "atendimento" => 0,
          "cd_paciente" => 0,
          "hospital_id" => hosp_id
        })



        response = Bulletins.create_bulletin(params)

      expected_response = %{
        atendimento: ["must be greater than 0"],
        nome: ["should be at least 2 character(s)"],
        obs: ["should be at least 6 character(s)"],
        cd_paciente: ["must be greater than 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
