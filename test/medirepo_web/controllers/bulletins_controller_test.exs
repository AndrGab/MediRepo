defmodule MedirepoWeb.BulletinsControllerTest do
  use MedirepoWeb.ConnCase, async: true

  alias Medirepo.{Bulletin, Hospital}
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
                 "atendimento" => 99_999,
                 "cd_paciente" => 88_888,
                 "consciencia" => "CONSCIENTE",
                 "diurese" => "NORMAL",
                 "dt_assinatura" => "2020-04-29",
                 "dt_nascimento" => "1977-01-28",
                 "febre" => "Ausente",
                 "geral" => "ESTAVEL",
                 "hospital_id" => _hosp_id,
                 "id" => _id,
                 "medico" => "ANTONIO CARLOS PETRUS",
                 "nome" => "Andre",
                 "obs" => "PACIENTE ESTA REAGINDO BEM",
                 "pressao" => "NORMAL",
                 "respiracao" => "NORMAL"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn, id: id} do
      params =
        build(:bulletin_params,
          hospital_id: id,
          nome: "A",
          obs: "obs",
          atendimento: -1,
          cd_paciente: -1
        )

      response =
        conn
        |> post(Routes.bulletins_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "atendimento" => ["must be greater than 0"],
          "cd_paciente" => ["must be greater than 0"],
          "nome" => ["should be at least 2 character(s)"],
          "obs" => ["should be at least 6 character(s)"]
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
      params = %Bulletin{id: id, nome: "Teste", obs: "123456"}

      response =
        conn
        |> put(Routes.bulletins_path(conn, :update, params))
        |> json_response(:ok)

      assert response == %{
               "bulletin" => %{
                 "atendimento" => 99_999,
                 "cd_paciente" => 88_888,
                 "consciencia" => "CONSCIENTE",
                 "diurese" => "NORMAL",
                 "dt_assinatura" => "2020-04-29",
                 "dt_nascimento" => "1977-01-28",
                 "febre" => "Ausente",
                 "geral" => "ESTAVEL",
                 "hospital_id" => "910a2168-b747-4c35-9c5e-74912c89213f",
                 "id" => "caf4c454-3b3e-4426-b754-80eb69a68cee",
                 "medico" => "ANTONIO CARLOS PETRUS",
                 "nome" => "Andre",
                 "obs" => "PACIENTE ESTA REAGINDO BEM",
                 "pressao" => "NORMAL",
                 "respiracao" => "NORMAL"
               }
             }
    end
  end
end
