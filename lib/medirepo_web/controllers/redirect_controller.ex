defmodule MedirepoWeb.RedirectController do
  use MedirepoWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("https://github.com/AndrGab/MediRepo")
  end
end
