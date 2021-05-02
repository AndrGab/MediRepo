defmodule MedirepoWeb.HospitalsController do
  use MedirepoWeb, :controller

  alias Medirepo.Hospital
  alias MedirepoWeb.FallbackController
  alias MedirepoWeb.Auth.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Hospital{} = hospital} <- Medirepo.create_hospital(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(hospital, %{}, ttl: {5, :minute}) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, hospital: hospital)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Hospital{} = hospital} <- Medirepo.get_hospital_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("hospital.json", hospital: hospital)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Hospital{}} <- Medirepo.delete_hospital(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %Hospital{} = hospital} <- Medirepo.update_hospital(params) do
      conn
      |> put_status(:ok)
      |> render("hospital.json", hospital: hospital)
    end
  end
end
