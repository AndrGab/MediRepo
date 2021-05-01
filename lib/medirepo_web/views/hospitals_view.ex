defmodule MedirepoWeb.HospitalsView do
  use MedirepoWeb, :view

  alias Medirepo.Hospital

  def render("create.json", %{hospital: %Hospital{} = hospital}) do
    %{
      message: "Hospital Created!",
      hospital: hospital
    }
  end

  def render("hospital.json", %{hospital: %Hospital{} = hospital}), do: %{hospital: hospital}

  def render("hospital.json", %{hospital: [%Hospital{} | _rest] = hospital}),
    do: %{hospital: hospital}
end
