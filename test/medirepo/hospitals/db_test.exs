defmodule Medirepo.Hospitals.DbTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins
  alias Medirepo.Error
  alias Medirepo.Hospitals.Db
  alias Medirepo.Hospitals.Models.Hospital

  import Medirepo.Factory

  describe "insert/1" do
    test "when all params are valid, returns the hospital" do
      params = build(:hospital_params)
      response = Db.insert(params)

      assert {:ok,
              %Hospital{
                id: _id,
                name: "Hospital das Americas",
                email: "contato@hospital.com",
                password: "123456"
              }} = response
    end

    test "when violates the email unique constraint" do
      insert(:hospital, email: "contato@hospital.com")
      params = build(:hospital_params, %{"email" => "contato@hospital.com"})

      response = Db.insert(params)

      expected_response = %{
        email: ["has already been taken"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:hospital_params, %{"name" => "T", "email" => "andreemail.com", "password" => "123"})

      response = Db.insert(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end

  describe "delete/1" do
    test "when id is valid, deletes the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Db.insert(params)

      response = Db.delete(id)

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
      response = Db.delete("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end

    test "when there are bulletins associated to the hospital, returns an error" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Db.insert(params)

      bul_params = build(:bulletin_params, %{"hospital_id" => id})

      Bulletins.create_bulletin(bul_params)

      response = Db.delete(id)

      expected_response = %{bulletin: ["are still associated with this entry"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end

  describe "get_by_id/1" do
    test "when id is valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Db.insert(params)

      response = Db.get_by_id(id)

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
      response = Db.get_by_id("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

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
       }} = Db.insert(params)

      response = Db.get_by_email(%{"email" => email})

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
      response = Db.get_by_email(%{"email" => "email@test.com"})

      expected_response = {:error, Error.build_hospital_not_found_error()}
      assert response == expected_response
    end

    test "when params are invalid, returns an error" do
      response = Db.get_by_email(%{"teste" => "email@test.com"})

      expected_response = {:error, %Error{result: "Invalid 3 Params", status: :bad_request}}
      assert response == expected_response
    end
  end

  describe "get_all/0" do
    test "get all hospital from database" do
      params = build(:hospital_params)
      Db.insert(params)

      response = Db.get_all()

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
      response = Db.get_all()

      expected_response = {:error, Error.build(:not_found, "Empty database")}
      assert response == expected_response
    end
  end

  describe "update/1" do
    test "when all params are valid, returns the hospital" do
      params = build(:hospital_params)

      {:ok,
       %Hospital{
         id: id
       }} = Db.insert(params)

      update_params = %{"id" => id, "name" => "Hospital de Teste", "password" => "123456"}

      response = Db.update(update_params)

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
        Db.update(%{
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
       }} = Db.insert(params)

      update_params = %{
        "id" => id,
        "password_reset_token" => "Teste",
        "password_sent_email_at" => NaiveDateTime.utc_now()
      }

      response = Db.update(update_params)

      assert {:ok,
              %Hospital{
                name: "Hospital das Americas",
                email: "contato@hospital.com",
                id: _id
              }} = response
    end
  end
end
