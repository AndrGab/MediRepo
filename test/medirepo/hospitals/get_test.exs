defmodule Medirepo.Hospitals.GetTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Error
  alias Medirepo.Hospitals
  alias Medirepo.Hospitals.Models.Hospital

  import Medirepo.Factory

  describe "get_by_id/1" do
    test "when id is valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Hospitals.create_hospital(params)

      response = Hospitals.get_hospital_by_id(id)

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
      response = Hospitals.get_hospital_by_id("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end
  end

  describe "get_by_email/1" do
    test "when email is valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         email: email
       }} = Hospitals.create_hospital(params)

      response = Hospitals.get_hospital_by_email(%{"email" => email})

      assert {:ok,
              %Hospital{
                email: "contato@hospital.com",
                name: "Hospital das Americas",
                id: _id,
                inserted_at: _inserted,
                updated_at: _updated
              }} = response
    end

    test "when an inexistent email is sent, returns an error" do
      response = Hospitals.get_hospital_by_email(%{"email" => "email@test.com"})

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end

    test "when params are invalid, returns an error" do
      response = Hospitals.get_hospital_by_email(%{"teste" => "email@test.com"})

      expected_response = {:error, %Error{result: "Invalid 3 Params", status: :bad_request}}
      assert response == expected_response
    end
  end

  describe "get_all/0" do
    test "get all hospital from database" do
      params = build(:hospital_params)
      Hospitals.create_hospital(params)

      response = Hospitals.get_hospitals()

      assert {:ok,
              [
                %Hospital{
                  email: nil,
                  name: "Hospital das Americas",
                  id: _id,
                  inserted_at: _inserted,
                  updated_at: _updated
                }
              ]} = response
    end

    test "Returns error when database is empty" do
      response = Hospitals.get_hospitals()

      expected_response = {:error, Error.build(:not_found, "Empty database")}
      assert response == expected_response
    end
  end
end
