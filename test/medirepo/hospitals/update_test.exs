defmodule Medirepo.Hospitals.UpdateTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.{Create, Update}

  import Medirepo.Factory

  describe "call/1" do
    test "when all params are valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Create.call(params)

      update_params = %{"id" => id, "name" => "Hospital de Teste", "password" => "123456"}

      response = Update.call(update_params)

      assert {:ok,
              %Hospital{
                name: "Hospital de Teste",
                email: "contato@hospital.com",
                id: _id,
                inserted_at: _inserted,
                updated_at: _updated
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response =
        Update.call(%{
          "id" => "22d9e500-bacb-4e30-997a-239e5c2bb6b8",
          "name" => "Hospital de Teste"
        })

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end
  end

  describe "reset_pass/1" do
    test "when id is correct, generates a token for reseting email" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Create.call(params)

      update_params = %{
        "id" => id,
        "password_reset_token" => "Teste",
        "password_sent_email_at" => NaiveDateTime.utc_now()
      }

      response = Update.call(update_params)

      assert {:ok,
              %Hospital{
                name: "Hospital das Americas",
                email: "contato@hospital.com",
                id: _id
              }} = response
    end
  end
end
