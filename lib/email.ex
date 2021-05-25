defmodule Medirepo.Email do
  import Bamboo.Email

  alias Medirepo.Mailer

  defp welcome_email(name, email, id) do
    new_email(
      to: email,
      from: "contact@medirepo.com",
      subject: "Welcome to the MediRepo",
      text_body:
        "Hi, #{name}\nThanks for joining us!\nYour ID is #{id}.\nUse your ID and password to login."
    )
  end

  defp reset_email(email, id, token) do
    new_email(
      to: email,
      from: "contact@medirepo.com",
      subject: "Reset password token",
      text_body:
        "Your ID is #{id}\nand your reset_token is #{token}.\nYou have 10 minutes to login."
    )
  end

  def send_welcome_email(name, email, id) do
    welcome_email(name, email, id)
    |> Mailer.deliver_later()
  end

  def send_reset_password_email(email, id, token) do
    reset_email(email, id, token)
    |> Mailer.deliver_later()
  end
end
