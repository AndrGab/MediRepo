defmodule MedirepoWeb.Resolvers.Hospital do
  alias Medirepo.Hospitals
  alias Ecto.Changeset
  alias Medirepo.Error

  def get_hospitals(_parent, _args, _resolution) do
    case Hospitals.get_hospitals() do
      {:error, _} -> []
      {:ok, result} -> {:ok, result}
    end
  end

  def create_hospital(_parent, %{input: params}, _resolution) do
    case Hospitals.create_hospital(params) do
      {:error, %Error{result: changeset}} ->
        {:error, message: "Could not create a hospital", details: error_details(changeset)}
      {:ok, result} -> {:ok, result}
    end
  end

  defp error_details(changeset) do
    Changeset.traverse_errors(changeset, fn {msg, _} -> msg end)
  end
end
