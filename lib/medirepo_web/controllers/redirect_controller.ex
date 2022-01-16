defmodule MedirepoWeb.RedirectController do
  use MedirepoWeb, :controller

  @config Application.get_all_env(:medirepo)[:zenvia]

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text(@config[:usuario])
  end
end
