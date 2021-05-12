defmodule MedirepoWeb.BulletinViewController do
  use MedirepoWeb, :controller

  alias Medirepo.Bulletin
  alias MedirepoWeb.Auth.Guardian
  alias Medirepo.Bulletins.GetValid
  alias MedirepoWeb.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    with {:ok, params} <- Guardian.current_bulletin(conn),
         {:ok, %Bulletin{} = bulletin} <- GetValid.call(params) do
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
