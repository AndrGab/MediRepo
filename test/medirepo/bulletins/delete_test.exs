defmodule Medirepo.Bulletins.DeleteTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Bulletin, Hospital}
  alias Medirepo.Bulletins.{Create, Delete}
  alias Medirepo.Hospitals.Create, as: HospCreate

  import Medirepo.Factory

  describe "call/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = HospCreate.call(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when id is valid, deletes the bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Create.call(params)

      response = Delete.call(id)

      assert {:ok,
              %Bulletin{
                nome: "Andre"
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Delete.call("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end
end
