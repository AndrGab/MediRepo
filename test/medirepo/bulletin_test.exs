defmodule Medirepo.BulletinTest do
  use Medirepo.DataCase, async: true

  import Medirepo.Factory

  alias Ecto.Changeset
  alias Medirepo.Bulletins.Models.Bulletin

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:bulletin_params)

      response = Bulletin.changeset(params)

      assert %Changeset{changes: %{name: "Andre"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:bulletin_params)

      update_params = %{"name" => "Hospital das Americas"}

      response =
        params
        |> Bulletin.changeset()
        |> Bulletin.changeset(update_params)

      assert %Changeset{changes: %{name: "Hospital das Americas"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params =
        build(:bulletin_params, %{
          "name" => "T",
          "notes" => "123",
          "attendance" => 0,
          "cd_patient" => 0,
          "hospital_id" => "21212112"
        })

      response = Bulletin.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        notes: ["should be at least 6 character(s)"],
        attendance: ["must be greater than 0"],
        cd_patient: ["must be greater than 0"]
      }

      assert errors_on(response) == expected_response
    end

    test "when there is an invalid UUID, returns an invalid changeset" do
      params =
        build(:bulletin_params, %{
          "hospital_id" => "21212112"
        })

      response = Bulletin.changeset(params)

      expected_response = %{
        hospital_id: ["Invalid UUID"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
