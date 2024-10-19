defmodule MedirepoWeb.Resolvers.Hospital do
  alias Ecto.Changeset
  alias Medirepo.Error
  alias Medirepo.Hospitals

  def get_hospitals(_parent, _args, _resolution) do
    case Hospitals.get_hospitals() do
      {:ok, result} -> {:ok, result}
      _error -> {:error, message: "Not found", details: "Empty database"}
    end
  end

  def create_hospital(_parent, %{input: params}, _resolution) do
    case Hospitals.create_hospital(params) do
      {:error, %Error{result: changeset}} ->
        {:error, message: "Could not create a hospital", details: error_details(changeset)}

      {:ok, result} ->
        {:ok, result}
    end
  end

  defp error_details(changeset) do
    Changeset.traverse_errors(changeset, fn {msg, _} -> msg end)
  end
end
