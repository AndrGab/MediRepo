defmodule MedirepoWeb.Auth.Guardian do
  use Guardian, otp_app: :medirepo

  alias Medirepo.Bulletins.GetValid, as: GetValid
  alias Medirepo.{Error, Hospital}
  alias Medirepo.Hospitals.Get, as: HospitalGet

  def subject_for_token(hospital_id, _claims) do
    {:ok, hospital_id}
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
    conn
    |> atual_token()
    |> decode_and_verify(%{ate: "000"})
    |> handle_hospital()
  end

  defp handle_hospital({:ok, %{"sub" => logged_hospital}}), do: {:ok, logged_hospital}

  defp handle_hospital({:error, _result}),
    do: {:error, Error.build(:unauthorized, "Access allowed just for Hospitals")}

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %Hospital{password_hash: hash, id: hospital_id}} <-
           HospitalGet.by_email(%{"email" => email}),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(hospital_id, %{ate: "000"}, ttl: {30, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  defp valid_reset_token?(token_sent_at) do
    current_time = NaiveDateTime.utc_now()
    Time.diff(current_time, token_sent_at) < 600
  end

  def with_reset_token(%{"id" => hospital_id, "reset_token" => _passed_token} = params) do
    with {:ok, %Hospital{password_sent_email_at: saved_dt_token}} <-
           HospitalGet.by_id_and_reset_token(params),
         true <- valid_reset_token?(saved_dt_token),
         {:ok, token, _claims} <- encode_and_sign(hospital_id, %{ate: "000"}, ttl: {30, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Request a new reset token")}
      error -> error
    end
  end

  def with_reset_token(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  def auth_view(
        %{
          "login" => cd_paciente,
          "password" => atendimento,
          "dt_nasc" => dt_nascimento,
          "id" => id
        } = params
      ) do
    with {:ok, _result} <- GetValid.call(params),
         {:ok, token, _claims} <-
           encode_and_sign(id, %{ate: atendimento, pac: cd_paciente, dat: dt_nascimento},
             ttl: {30, :minute}
           ) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Invalid information for bulletins")}
      error -> error
    end
  end

  def auth_view(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  def current_bulletin(conn) do
    conn
    |> atual_token()
    |> decode_and_verify()
    |> handle_bulletin()
  end

  defp handle_bulletin(
         {:ok,
          %{
            "pac" => vl_login,
            "ate" => vl_password,
            "dat" => vl_date,
            "sub" => id
          }}
       ) do
    {:ok,
     %{
       "login" => vl_login,
       "password" => vl_password,
       "dt_nasc" => vl_date,
       "id" => id
     }}
  end

  defp handle_bulletin({:error, _result}),
    do: {:error, Error.build(:unauthorized, "Given information is invalid")}

  defp handle_bulletin(_),
    do: {:error, Error.build(:unauthorized, "Invalid or missing params")}
end
