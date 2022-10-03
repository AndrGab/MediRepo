defmodule Medirepo.Hospitals.CreateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Error
  alias Medirepo.Hospitals
  alias Medirepo.Hospitals.Models.Hospital

  import Medirepo.Factory

  describe "call/1" do
    test "when all params are valid, returns the hospital" do
      params = build(:hospital_params)
      response = Hospitals.create_hospital(params)

      assert {:ok,
              %Hospital{
                id: _id,
                name: "Hospital das Americas",
                email: "contato@hospital.com",
                password: "123456"
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:hospital_params, %{"name" => "T", "email" => "andreemail.com", "password" => "123"})

      response = Hospitals.create_hospital(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
