defmodule Medirepo.Hospitals.CreateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.Create

  import Medirepo.Factory

  describe "call/1" do
    test "when all params are valid, returns the hospital" do
      params = build(:hospital_params)
      response = Create.call(params)

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

      response = Create.call(params)

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
