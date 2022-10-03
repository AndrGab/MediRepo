defmodule Medirepo.Bulletins.DbTest do
  use Medirepo.DataCase, async: true

  alias Medirepo.Bulletins.Db
  alias Medirepo.Bulletins.Models.Bulletin
  alias Medirepo.Error
  alias Medirepo.Hospitals
  alias Medirepo.Hospitals.Models.Hospital

  import Medirepo.Factory

  describe "insert/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when all params are valid, returns the Bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      response = Db.insert(params)

      assert {:ok,
              %Bulletin{
                id: _id,
                name: "Andre",
                dt_birth: _dt_nasc,
                general: "ESTAVEL",
                pressure: "NORMAL",
                conscience: "CONSCIENTE",
                fever: "Ausente",
                respiration: "NORMAL",
                diurese: "NORMAL",
                notes: "PACIENTE ESTA REAGINDO BEM",
                doctor: "ANTONIO CARLOS PETRUS",
                dt_signature: _dt_assin,
                attendance: 99_999,
                cd_patient: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when there are invalid params, returns an error", %{hosp_id: hosp_id} do
      params =
        build(:bulletin_params, %{
          "name" => "T",
          "notes" => "123",
          "attendance" => 0,
          "cd_patient" => 0,
          "hospital_id" => hosp_id
        })

      response = Db.insert(params)

      expected_response = %{
        attendance: ["must be greater than 0"],
        name: ["should be at least 2 character(s)"],
        notes: ["should be at least 6 character(s)"],
        cd_patient: ["must be greater than 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end

  describe "delete/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when id is valid, deletes the bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Db.insert(params)

      response = Db.delete(id)

      assert {:ok,
              %Bulletin{
                name: "Andre"
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Db.delete("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end

  describe "get_by_id/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when id is valid, returns the bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Db.insert(params)

      response = Db.get_by_id(id)

      assert {:ok,
              %Bulletin{
                name: "Andre"
              }} = response
    end

    test "when an inexistent id is sent, returns an error" do
      response = Db.get_by_id("22d9e500-bacb-4e30-997a-239e5c2bb6b8")

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
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "get all bulletins from database", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      Db.insert(params)

      response = Db.get_all()

      assert {:ok,
              [
                %Bulletin{
                  name: "Andre"
                }
              ]} = response
    end

    test "Returns error when database is empty" do
      response = Db.get_all()

      expected_response = {:error, Error.build(:not_found, "Empty database")}
      assert response == expected_response
    end
  end

  describe "get_valid/4" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      {:ok, hosp_id: hosp_id}
    end

    test "when id is valid, returns the bulletin", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         dt_birth: dt_nasc,
         attendance: atend,
         cd_patient: cd_pac
       }} = Db.insert(params)

      response =
        Db.get_valid(%{
          "login" => cd_pac,
          "password" => atend,
          "dt_nasc" => dt_nasc,
          "id" => hosp_id
        })

      assert {:ok,
              %Bulletin{
                name: "Andre"
              }} = response
    end

    test "when id is invalid, returns an error", %{hosp_id: hosp_id} do
      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         dt_birth: dt_nasc,
         attendance: atend,
         cd_patient: _cd_pac
       }} = Db.insert(params)

      response =
        Db.get_valid(%{
          "login" => 9999,
          "password" => atend,
          "dt_nasc" => dt_nasc,
          "id" => hosp_id
        })

      assert {:error, %Medirepo.Error{result: "Bulletin not found", status: :not_found}} =
               response
    end
  end

  describe "update/1" do
    setup do
      params_hosp = build(:hospital_params)

      {:ok,
       %Hospital{
         id: hosp_id
       }} = Hospitals.create_hospital(params_hosp)

      params = build(:bulletin_params, %{"hospital_id" => hosp_id})

      {:ok,
       %Bulletin{
         id: id
       }} = Db.insert(params)

      {:ok, id: id}
    end

    test "when all params are valid, returns the bulletin", %{id: id} do
      update_params = %{"id" => id, "name" => "Andre", "notes" => "PACIENTE"}

      response = Db.update(update_params)

      assert {:ok,
              %Bulletin{
                id: _id,
                name: "Andre",
                dt_birth: _dt_nasc,
                general: "ESTAVEL",
                pressure: "NORMAL",
                conscience: "CONSCIENTE",
                fever: "Ausente",
                respiration: "NORMAL",
                diurese: "NORMAL",
                notes: "PACIENTE",
                doctor: "ANTONIO CARLOS PETRUS",
                dt_signature: _dt_assin,
                attendance: 99_999,
                cd_patient: 88_888,
                hospital_id: _hosp_id
              }} = response
    end

    test "when there are invalid params, returns an error", %{id: id} do
      update_params = %{"id" => id, "name" => "A", "notes" => "P"}

      response = Db.update(update_params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        notes: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when an inexistent id is sent, returns an error" do
      response =
        Db.update(%{
          "id" => "22d9e500-bacb-4e30-997a-239e5c2bb6b8",
          "name" => "Hospital de Teste"
        })

      expected_response = {:error, Error.build_bulletin_not_found_error()}
      assert response == expected_response
    end
  end
end
