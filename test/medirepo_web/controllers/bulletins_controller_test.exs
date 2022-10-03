defmodule MedirepoWeb.BulletinsControllerTest do
  use MedirepoWeb.ConnCase, async: true

  alias Medirepo.Bulletins.Models.Bulletin
  alias Medirepo.Hospitals.Models.Hospital
  alias MedirepoWeb.Auth.Guardian

  import Medirepo.Factory

  describe "create/2" do
    setup %{conn: conn} do
      hospital = insert(:hospital)
      %Hospital{id: id} = hospital
      {:ok, token, _claims} = Guardian.encode_and_sign(id, %{ate: "000"})
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn, id: id}
    end

    test "when all params are valid, creates a bulletin", %{conn: conn, id: id} do
      params = build(:bulletin_params, hospital_id: id)

      response =
        conn
        |> post(Routes.bulletins_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Bulletin Created!",
               "bulletin" => %{
                 "attendance" => 99_999,
                 "cd_patient" => 88_888,
                 "conscience" => "CONSCIENTE",
                 "diurese" => "NORMAL",
                 "dt_signature" => "2020-04-29",
                 "dt_birth" => "1977-01-28",
                 "fever" => "Ausente",
                 "general" => "ESTAVEL",
                 "hospital_id" => _hosp_id,
                 "id" => _id,
                 "doctor" => "ANTONIO CARLOS PETRUS",
                 "name" => "Andre",
                 "notes" => "PACIENTE ESTA REAGINDO BEM",
                 "pressure" => "NORMAL",
                 "respiration" => "NORMAL"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn, id: id} do
      params =
        build(:bulletin_params,
          hospital_id: id,
          name: "A",
          notes: "notes",
          attendance: -1,
          cd_patient: -1
        )

      response =
        conn
        |> post(Routes.bulletins_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "attendance" => ["must be greater than 0"],
          "cd_patient" => ["must be greater than 0"],
          "name" => ["should be at least 2 character(s)"],
          "notes" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      hospital = insert(:hospital)
      %Hospital{id: id} = hospital
      {:ok, token, _claims} = Guardian.encode_and_sign(id, %{ate: "000"})
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      bulletin = insert(:bulletin, hospital_id: id)
      %Bulletin{id: bul_id} = bulletin
      {:ok, conn: conn, id: bul_id}
    end

    test "when there is a bulletin with the given id, deletes the bulletin", %{
      conn: conn,
      id: bul_id
    } do
      response =
        conn
        |> delete(Routes.bulletins_path(conn, :delete, %Bulletin{id: bul_id}))
        |> response(:no_content)

      assert response == ""
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      hospital = insert(:hospital)
      %Hospital{id: id} = hospital
      {:ok, token, _claims} = Guardian.encode_and_sign(id, %{ate: "000"})
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      bulletin = insert(:bulletin, hospital_id: id)
      %Bulletin{id: bul_id} = bulletin
      {:ok, conn: conn, id: bul_id}
    end

    test "when there is a hospital with the given id, updates the hospital", %{
      conn: conn,
      id: id
    } do
      params = %Bulletin{id: id, name: "Teste", notes: "123456"}

      response =
        conn
        |> put(Routes.bulletins_path(conn, :update, params))
        |> json_response(:ok)

      assert response == %{
               "bulletin" => %{
                 "attendance" => 99_999,
                 "cd_patient" => 88_888,
                 "conscience" => "CONSCIENTE",
                 "diurese" => "NORMAL",
                 "dt_signature" => "2020-04-29",
                 "dt_birth" => "1977-01-28",
                 "fever" => "Ausente",
                 "general" => "ESTAVEL",
                 "hospital_id" => "910a2168-b747-4c35-9c5e-74912c89213f",
                 "id" => "caf4c454-3b3e-4426-b754-80eb69a68cee",
                 "doctor" => "ANTONIO CARLOS PETRUS",
                 "name" => "Andre",
                 "notes" => "PACIENTE ESTA REAGINDO BEM",
                 "pressure" => "NORMAL",
                 "respiration" => "NORMAL"
               }
             }
    end
  end

  describe "show/2" do
    setup %{conn: conn} do
      hospital = insert(:hospital)
      %Hospital{id: id} = hospital
      {:ok, token, _claims} = Guardian.encode_and_sign(id, %{ate: "000"})
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      bulletin = insert(:bulletin, hospital_id: id)
      %Bulletin{id: bul_id} = bulletin
      {:ok, conn: conn, id: bul_id}
    end

    test "when there is a hospital with the given id, shows the hospital", %{
      conn: conn,
      id: id
    } do
      params = %Bulletin{id: id}

      response =
        conn
        |> get(Routes.bulletins_path(conn, :show, params))
        |> json_response(:ok)

      assert response == %{
               "bulletin" => %{
                 "attendance" => 99_999,
                 "cd_patient" => 88_888,
                 "conscience" => "CONSCIENTE",
                 "diurese" => "NORMAL",
                 "dt_signature" => "2020-04-29",
                 "dt_birth" => "1977-01-28",
                 "fever" => "Ausente",
                 "general" => "ESTAVEL",
                 "hospital_id" => "910a2168-b747-4c35-9c5e-74912c89213f",
                 "id" => "caf4c454-3b3e-4426-b754-80eb69a68cee",
                 "doctor" => "ANTONIO CARLOS PETRUS",
                 "name" => "Andre",
                 "notes" => "PACIENTE ESTA REAGINDO BEM",
                 "pressure" => "NORMAL",
                 "respiration" => "NORMAL"
               }
             }
    end

    test "when bulletin's id is invalid, returns an error", %{
      conn: conn
    } do
      params = %Bulletin{id: "910a2168-b747-4c35-9c5e-74912c89213f"}

      response =
        conn
        |> get(Routes.bulletins_path(conn, :show, params))
        |> json_response(:not_found)

      assert response == %{"message" => "Bulletin not found"}
    end

    test "when bulletin's uuid is invalid, returns an error", %{
      conn: conn
    } do
      params = %Bulletin{id: "910a2168-b747-4c35"}

      response =
        conn
        |> get(Routes.bulletins_path(conn, :show, params))
        |> json_response(:bad_request)

      assert response == %{"message" => "Invalid UUID"}
    end
  end
end
