defmodule Medirepo.HospitalTest do
  use Medirepo.DataCase, async: true

  import Medirepo.Factory

  alias Medirepo.Hospital
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:hospital_params)

      response = Hospital.changeset(params)

      assert %Changeset{changes: %{name: "Hospital das Americas"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:hospital_params)

      update_params = %{"name" => "Hospital das Americas"}

      response =
        params
        |> Hospital.changeset()
        |> Hospital.changeset(update_params)

      assert %Changeset{changes: %{name: "Hospital das Americas"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:hospital_params, %{"email" => "contatohospital.com", "password" => "123"})

      response = Hospital.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
