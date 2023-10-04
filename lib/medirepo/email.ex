defmodule Medirepo.Email do
  import Bamboo.Email

  alias Medirepo.Mailer

  @email_address Application.compile_env(:medirepo, :email_address, "contact@medirepo.com")

  def send_welcome_email(name, email, id) do
    welcome_email(name, email, id)
    |> Mailer.deliver_later()
  end

  defp welcome_email(name, email, _id) do
    new_email(
      to: email,
      from: @email_address,
      subject: "Welcome to MediRepo",
      text_body: "Hello, #{name}\n
        Thank you for joining us!\n
        Use your registered email and password to login to the platform\n
        https://medirepo.vercel.app/"
    )
  end

  def send_reset_password_email(email, id, token) do
    reset_email(email, id, token)
    |> Mailer.deliver_later()
  end

  defp reset_email(email, id, token) do
    new_email(
      to: email,
      from: @email_address,
      subject: "Reset password token",
      text_body: "Use the link below to log into the platform and update your password:\n
        https://medirepo.vercel.app/hospitals/fastlogin/#{id}/#{token} \n
        This access link expires in 10 minutes.\n
        Thank you."
    )
  end
end
