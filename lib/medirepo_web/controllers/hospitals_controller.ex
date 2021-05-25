defmodule MedirepoWeb.HospitalsController do
  use MedirepoWeb, :controller

  alias Medirepo.{Email, Hospital}
  alias MedirepoWeb.Auth.Guardian
  alias MedirepoWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Hospital{id: hospital, name: name, email: email}} <-
           Medirepo.create_hospital(params),
         {:ok, token, _claims} <-
           Guardian.encode_and_sign(hospital, %{ate: "000"}, ttl: {30, :minute}),
         {:ok, _email} <- Email.send_welcome_email(name, email, hospital) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, hospital: hospital)
    end
  end

  def delete(conn, _params) do
    with {:ok, logged_hospital} <- Guardian.current_hospital(conn),
         {:ok, %Hospital{}} <- Medirepo.delete_hospital(logged_hospital) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, logged_hospital} <- Guardian.current_hospital(conn),
         {:ok, %Hospital{} = hospital} <- Medirepo.get_hospital_by_id(logged_hospital) do
      conn
      |> put_status(:ok)
      |> render("hospital.json", hospital: hospital)
    end
  end

  def reset_password(conn, params) do
    with {:ok, %Hospital{id: id, email: email}} <- Medirepo.get_hospital_by_email(params),
         {:ok, %Hospital{password_reset_token: token} = hospital} <- Medirepo.reset_password(id),
         {:ok, _email} <- Email.send_reset_password_email(email, id, token) do
      conn
      |> put_status(:ok)
      |> render("reset.json", hospital: hospital)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def fast_login(conn, params) do
    with {:ok, token} <- Guardian.with_reset_token(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def show_list(conn, _params) do
    with {:ok, hospital} <- Medirepo.get_hospitals() do
      conn
      |> put_status(:ok)
      |> render("hospital.json", hospital: hospital)
    end
  end

  def update(conn, params) do
    with {:ok, logged_hospital} <- Guardian.current_hospital(conn) do
      params = Map.put(params, "id", logged_hospital)

      with {:ok, %Hospital{} = hospital} <- Medirepo.update_hospital(params) do
        conn
        |> put_status(:ok)
        |> render("hospital.json", hospital: hospital)
      end
    end
  end
end
