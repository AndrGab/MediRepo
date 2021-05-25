defmodule MedirepoWeb.HospitalsView do
  use MedirepoWeb, :view

  alias Medirepo.Hospital

  def render("create.json", %{hospital: %Hospital{} = hospital, token: token}) do
    %{
      message: "Hospital Created!",
      hospital: hospital,
      token: token
    }
  end

  def render("create.json", %{hospital: hospital, token: token}) do
    %{
      message: "Hospital Created!",
      hospital: hospital,
      token: token
    }
  end

  def render("hospital.json", %{hospital: %Hospital{} = hospital}), do: %{hospital: hospital}

  def render("hospital.json", %{hospital: [%Hospital{} | _rest] = hospital}),
    do: %{hospital: hospital}

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("reset.json", %{
        hospital: %Hospital{email: email}
      }) do
    %{
      message: "A reset token was sent by email",
      email: email
    }
  end
end
