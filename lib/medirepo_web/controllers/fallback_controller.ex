defmodule MedirepoWeb.FallbackController do
  use MedirepoWeb, :controller

  alias Medirepo.Error
  alias MedirepoWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", %{result: result})
  end
end
