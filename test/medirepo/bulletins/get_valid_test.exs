defmodule Medirepo.Bulletins.GetValidTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins
  alias Medirepo.Models.Bulletin
  alias Medirepo.Hospital
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "get_valid/4" do
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
       }} = Bulletins.create_bulletin(params)

      response =

        Bulletins.get_valid(%{
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

    test "when id is invalid, returns an error", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         dt_nascimento: dt_nasc,
         atendimento: atend,
         cd_paciente: _cd_pac
       }} =Bulletins.create_bulletin(params)

      response =
        Bulletins.get_valid(%{
          "login" => 9999,
          "password" => atend,
          "dt_nasc" => dt_nasc,
          "id" => hosp_id
        })

      assert {:error, %Medirepo.Error{result: "Bulletin not found", status: :not_found}} =
               response
    end
  end
end
