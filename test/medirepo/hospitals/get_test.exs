defmodule Medirepo.Hospitals.GetTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.{Create, Get}

  import Medirepo.Factory

  describe "by_id/1" do
    test "when id is valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Create.call(params)

      response = Get.by_id(id)

      assert {:ok,
              %Hospital{
                email: "contato@hospital.com",
                name: "Hospital das Americas",
                id: _id,
                inserted_at: _inserted,
                updated_at: _updated
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Get.by_id("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end
  end

  describe "get_all/0" do
    test "get all hospital from database" do
      params = build(:hospital_params)
      Create.call(params)

      response = Get.get_all()

      assert {:ok,
              [
                %Hospital{
                  email: "contato@hospital.com",
                  name: "Hospital das Americas",
                  id: _id,
                  inserted_at: _inserted,
                  updated_at: _updated
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
