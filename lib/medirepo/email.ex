defmodule Medirepo.Email do
  import Bamboo.Email

  alias Medirepo.Mailer

  def send_welcome_email(name, email, id) do
    welcome_email(name, email, id)
    |> Mailer.deliver_later()
  end

  defp welcome_email(name, email, id) do
    new_email(
      to: email,
      from: "contact@medirepo.com",
      subject: "Welcome to the MediRepo",
      text_body:
        "Hi, #{name}\nThanks for joining us!\nYour ID is #{id}.\nUse your ID and password to login."
    )
  end

  def send_reset_password_email(email, id, token) do
    reset_email(email, id, token)
    |> Mailer.deliver_later()
  end

  defp reset_email(email, id, token) do
    new_email(
      to: email,
      from: "contact@medirepo.com",
      subject: "Reset password token",
      text_body:
        "Your ID is #{id}\nand your reset_token is #{token}.\nhttp://localhost:3000/hospitals/fastlogin/#{id}/#{token} \nYou have 10 minutes to login."
    )
  end
end
