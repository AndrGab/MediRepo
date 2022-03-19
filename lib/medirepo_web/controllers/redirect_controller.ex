defmodule MedirepoWeb.RedirectController do
  use MedirepoWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text(System.get_env("SMTP_USERNAME"))
  end
end
