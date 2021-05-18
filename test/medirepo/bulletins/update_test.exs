defmodule Medirepo.Bulletins.UpdateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Bulletin, Hospital}
  alias Medirepo.Bulletins.{Create, Update}
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "call/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = HospCreate.call(params_hosp)

      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Create.call(params)

      {:ok, id: id}
    end

    test "when all params are valid, returns the bulletin", %{id: id} do
      update_params = %{"id" => id, "nome" => "Andre", "obs" => "PACIENTE"}

      response = Update.call(update_params)

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
                obs: "PACIENTE",
                medico: "ANTONIO CARLOS PETRUS",
                dt_assinatura: _dt_assin,
                atendimento: 99_999,
                cd_paciente: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response =
        Update.call(%{
          "id" => "22d9e500-bacb-4e30-997a-239e5c2bb6b8",
          "name" => "Hospital de Teste"
        })

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end
end
