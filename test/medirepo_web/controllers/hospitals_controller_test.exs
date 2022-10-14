defmodule MedirepoWeb.HospitalsControllerTest do
  use MedirepoWeb.ConnCase, async: true

  alias Medirepo.Hospitals.Models.Hospital
  alias MedirepoWeb.Auth.Guardian

  import Medirepo.Factory

  @invalid_login_attrs %{"email" => "hospital@wrong.com", "password" => "wrong_password"}
  @valid_login_attrs %{"email" => "hospital@email.com", "password" => "hospital"}

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

  describe "sign_in/2" do
    setup %{conn: conn} do
      Medirepo.Hospitals.create_hospital(%{
        email: "hospital@email.com",
        name: "hospital",
        password: "hospital"
      })

      {:ok, conn: conn}
    end

    test "when all params are valid, signs in the user", %{conn: conn} do
      response =
        conn
        |> post(Routes.hospitals_path(conn, :sign_in, @valid_login_attrs))
        |> json_response(:ok)

      assert Map.has_key?(response, "token")
    end

    test "when all params are invalid, returns an error message", %{conn: conn} do
      response =
        conn
        |> post(Routes.hospitals_path(conn, :sign_in, @invalid_login_attrs))
        |> json_response(:not_found)

      refute Map.has_key?(response, "token")
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      setup_hospital(conn)
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

  describe "index/2" do
    setup %{conn: conn} do
      setup_hospital(conn)
    end

    test "Shows the logged hospital", %{
      conn: conn,
      id: id,
      hospital_name: hospital_name,
      hospital_email: hospital_email
    } do
      response =
        conn
        |> get(Routes.hospitals_path(conn, :index))
        |> json_response(:ok)

      assert response == %{
               "hospital" => %{
                 "id" => id,
                 "name" => hospital_name,
                 "email" => hospital_email
               }
             }
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      setup_hospital(conn)
    end

    test "when there is a hospital with the given id, updates the hospital", %{
      conn: conn,
      id: id,
      hospital_email: hospital_email
    } do
      params = %{id: id, name: "Teste", password: "123456"}

      response =
        conn
        |> put(Routes.hospitals_path(conn, :update, params))
        |> json_response(:ok)

      assert response == %{
               "hospital" => %{
                 "id" => id,
                 "name" => "Teste",
                 "email" => hospital_email
               }
             }
    end
  end

  describe "show_list/2" do
    setup %{conn: conn} do
      setup_hospital(conn)
    end

    test "list all hospitals", %{
      conn: conn,
      id: id,
      hospital_name: hospital_name
    } do
      response =
        conn
        |> get(Routes.hospitals_path(conn, :show_list))
        |> json_response(:ok)

      assert response == %{
               "hospital" => [
                 %{
                   "id" => id,
                   "name" => hospital_name,
                   "email" => nil
                 }
               ]
             }
    end
  end

  defp setup_hospital(conn) do
    %Hospital{id: id, name: hospital_name, email: hospital_email} = insert(:hospital)
    {:ok, token, _claims} = Guardian.encode_and_sign(id, %{ate: "000"})
    conn = put_req_header(conn, "authorization", "Bearer #{token}")
    {:ok, conn: conn, id: id, hospital_name: hospital_name, hospital_email: hospital_email}
  end
end
