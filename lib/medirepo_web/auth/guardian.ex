defmodule MedirepoWeb.Auth.Guardian do
  use Guardian, otp_app: :medirepo

  alias Medirepo.{Hospital, Error}
  alias Medirepo.Hospitals.Get, as: HospitalGet

  def subject_for_token(%Hospital{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> HospitalGet.by_id()
  end

  def atual_token(conn) do
    Guardian.Plug.current_token(conn)
  end

  def current_hospital(conn) do
    token = atual_token(conn)
    {:ok, %{"sub" => logged_hospital}} = decode_and_verify(token)
    logged_hospital
  end

  def authenticate(%{"id" => hospital_id, "password" => password}) do
    with {:ok, %Hospital{password_hash: hash} = hospital} <- HospitalGet.by_id(hospital_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(hospital, %{}, ttl: {30, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
