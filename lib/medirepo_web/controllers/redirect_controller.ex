defmodule MedirepoWeb.RedirectController do
  use MedirepoWeb, :controller

  def index(conn, _params) do
    IO.inspect(System.get_env("SMTP_USERNAME"))
    IO.inspect(System.get_env("SMTP_PASSWORD"))

    conn
    |> put_status(:ok)
    |> text("https://github.com/AndrGab/MediRepo")
  end
end
