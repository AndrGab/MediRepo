defmodule Medirepo.Email do
  import Bamboo.Email

  alias Medirepo.Mailer

  def send_welcome_email(name, email, id) do
    welcome_email(name, email, id)
    |> Mailer.deliver_later()
  end

  defp welcome_email(name, email, _id) do
    new_email(
      to: email,
      from: "andre.gabriel@elxdev.com",
      subject: "Bem-vindo ao MediRepo",
      text_body:
        "Olá, #{name}\nObrigado por se juntar a nós!\nUse seu e-mail e senha cadastrados para logar na plataforma.\nhttps://medirepo.vercel.app/"
    )
  end

  def send_reset_password_email(email, id, token) do
    reset_email(email, id, token)
    |> Mailer.deliver_later()
  end

  defp reset_email(email, id, token) do
    new_email(
      to: email,
      from: "andre.gabriel@elxdev.com",
      subject: "Reset password token",
      text_body:
        "Utilize o link abaixo para logar na plataforma e atualize sua senha:\nhttps://medirepo.vercel.app/hospitals/fastlogin/#{
          id
        }/#{token} \nEsse link de acesso expira em 10 minutos.\nObrigado"
    )
  end
end
