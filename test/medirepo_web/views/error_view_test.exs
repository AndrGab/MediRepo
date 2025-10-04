defmodule MedirepoWeb.ErrorViewTest do
  use MedirepoWeb.ConnCase, async: true

  test "renders 404.json" do
    assert MedirepoWeb.ErrorView.template_not_found("404.json", []) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500.json" do
    assert MedirepoWeb.ErrorView.template_not_found("500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
