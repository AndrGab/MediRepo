defmodule MedirepoWeb.RedirectControllerTest do
  use MedirepoWeb.ConnCase, async: true

  describe "index/0" do
    test "Returns a redirect message", %{conn: conn} do
      response =
        conn
        |> get(Routes.redirect_path(conn, :index))
        |> text_response(:ok)

      expected_response = "https://github.com/AndrGab/MediRepo"
      assert expected_response == response
    end
  end
end
