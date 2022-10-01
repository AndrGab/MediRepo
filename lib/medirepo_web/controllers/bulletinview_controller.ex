defmodule MedirepoWeb.BulletinViewController do
  use MedirepoWeb, :controller

  alias Medirepo.Bulletins
  alias Medirepo.Bulletins.Models.Bulletin
  alias MedirepoWeb.Auth.Guardian
  alias MedirepoWeb.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    with {:ok, params} <- Guardian.current_bulletin(conn),
         {:ok, %Bulletin{} = bulletin} <- Bulletins.get_valid(params) do
      conn
      |> put_status(:ok)
      |> render("bulletin.json", bulletin: bulletin)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.auth_view(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
