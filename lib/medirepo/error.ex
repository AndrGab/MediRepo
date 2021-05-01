defmodule Medirepo.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_hospital_not_found_error, do: build(:not_found, "Hospital not found")
  def build_bulletin_not_found_error, do: build(:not_found, "Bulletin not found")
end
