defmodule Medirepo.Bulletins.GetTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Bulletin, Hospital}
  alias Medirepo.Bulletins.{Create, Get}
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "by_id/1" do
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
         id: id
       }} = Create.call(params)

      response = Get.by_id(id)

      assert {:ok,
              %Bulletin{
                nome: "Andre"
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Get.by_id("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end

  describe "get_all/0" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = HospCreate.call(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "get all bulletins from database", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      Create.call(params)

      response = Get.get_all()

      assert {:ok,
              [
                %Bulletin{
                  nome: "Andre"
                }
              ]} = response
    end

    test "Returns error when database is empty" do
      response = Get.get_all()

      expected_response = {:error, Error.build(:not_found, "Empty database")}
      assert response == expected_response
    end
  end
end
