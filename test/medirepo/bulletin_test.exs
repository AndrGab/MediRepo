defmodule Medirepo.BulletinTest do
  use Medirepo.DataCase, async: true

  import Medirepo.Factory

  alias Medirepo.Bulletin
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:bulletin_params)

      response = Bulletin.changeset(params)

      assert %Changeset{changes: %{nome: "Andre"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:bulletin_params)

      update_params = %{"nome" => "Hospital das Americas"}

      response =
        params
        |> Bulletin.changeset()
        |> Bulletin.changeset(update_params)

      assert %Changeset{changes: %{nome: "Hospital das Americas"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:bulletin_params, %{"nome" => "T", "obs" => "123"})

      response = Bulletin.changeset(params)

      expected_response = %{
        nome: ["should be at least 2 character(s)"],
        obs: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
