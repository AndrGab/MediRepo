defmodule Medirepo.Bulletins.GetValidTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Bulletin, Hospital}
  alias Medirepo.Bulletins.{Create, GetValid}
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "call/4" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = HospCreate.call(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when id is valid, returns the bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         dt_nascimento: dt_nasc,
         atendimento: atend,
         cd_paciente: cd_pac
       }} = Create.call(params)

      response =
        GetValid.call(%{
          "login" => cd_pac,
          "password" => atend,
          "dt_nasc" => dt_nasc,
          "id" => hosp_id
        })

      assert {:ok,
              %Bulletin{
                nome: "Andre"
              }} = response
    end
  end
end
