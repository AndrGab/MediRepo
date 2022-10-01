defmodule MedirepoWeb.BulletinViewView do
  use MedirepoWeb, :view

  alias Medirepo.Models.Bulletin

  def render("bulletin.json", %{bulletin: %Bulletin{} = bulletin}), do: %{bulletin: bulletin}

  def render("bulletin.json", %{bulletin: [%Bulletin{} | _rest] = bulletin}),
    do: %{bulletin: bulletin}

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
