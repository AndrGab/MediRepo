defmodule Medirepo.Hospitals.DeleteTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins.Create, as: CreateBulletin
  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.{Create, Delete}

  import Medirepo.Factory

  describe "call/1" do
    test "when id is valid, deletes the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Create.call(params)

      response = Delete.call(id)

      assert {:ok,
              %Hospital{
                name: "Hospital das Americas",
                email: "contato@hospital.com",
                id: _id,
                inserted_at: _inserted,
                updated_at: _updated
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Delete.call("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end

    test "when there are bulletins associated to the hospital, returns an error" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Create.call(params)

      bul_params = build(:bulletin_params, %{"hospital_id" => id})

      CreateBulletin.call(bul_params)

      response = Delete.call(id)

      expected_response = %{bulletin: ["are still associated with this entry"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
