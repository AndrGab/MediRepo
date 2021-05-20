defmodule MedirepoWeb.HospitalsControllerTest do
  use MedirepoWeb.ConnCase, async: true

  alias Medirepo.Hospital
  alias MedirepoWeb.Auth.Guardian
  import Medirepo.Factory

  describe "create/2" do
    test "when all params are valid, creates the hospital", %{conn: conn} do
      params = %{
        "name" => "Hospital das Americas",
        "email" => "contato@hospital.com",
        "password" => "123456"
      }

      response =
        conn
        |> post(Routes.hospitals_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Hospital Created!",
               "hospital" => _id,
               "token" => _token
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "name" => "A"
      }

      response =
        conn
        |> post(Routes.hospitals_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "email" => ["can't be blank"],
          "name" => ["should be at least 2 character(s)"],
          "password" => ["can't be blank"]
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
      {:ok, conn: conn, id: id}
    end

    test "when there is a hospital with the given id, deletes the hospital", %{
      conn: conn,
      id: id
    } do
      response =
        conn
        |> delete(Routes.hospitals_path(conn, :delete, %{id: id}))
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
      {:ok, conn: conn, id: id}
    end

    test "when there is a hospital with the given id, updates the hospital", %{
      conn: conn,
      id: id
    } do
      params = %{id: id, name: "Teste", password: "123456"}

      response =
        conn
        |> put(Routes.hospitals_path(conn, :update, params))
        |> json_response(:ok)

      assert response == %{
               "hospital" => %{
                 "email" => "contato@hospital.com",
                 "id" => "910a2168-b747-4c35-9c5e-74912c89213f",
                 "name" => "Teste"
               }
             }
    end
  end
end
