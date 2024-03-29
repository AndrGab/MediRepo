defmodule MedirepoWeb.BulletinsView do
  use MedirepoWeb, :view

  alias Medirepo.Bulletins.Models.Bulletin

  def render("create.json", %{bulletin: %Bulletin{} = bulletin}) do
    %{
      message: "Bulletin Created!",
      bulletin: bulletin
    }
  end

  def render("bulletin.json", %{bulletin: %Bulletin{} = bulletin}), do: %{bulletin: bulletin}

  def render("bulletin.json", %{bulletin: [%Bulletin{} | _rest] = bulletin}),
    do: %{bulletin: bulletin}
end
