defmodule Medirepo.Factory do
  use ExMachina.Ecto, repo: Medirepo.Repo

  alias Medirepo.{Bulletin, Hospital}

  def hospital_params_factory do
    %{
      "name" => "Hospital das Americas",
      "email" => "contato@hospital.com",
      "password" => "123456"
    }
  end

  def hospital_factory do
    %Hospital{
      email: "contato@hospital.com",
      password: "123456",
      name: "Hospital das Americas",
      id: "910a2168-b747-4c35-9c5e-74912c89213f"
    }
  end

  def bulletin_params_factory do
    %{
      "nome" => "Andre",
      "dt_nascimento" => "1977-01-28",
      "geral" => "ESTAVEL",
      "pressao" => "NORMAL",
      "consciencia" => "CONSCIENTE",
      "febre" => "Ausente",
      "respiracao" => "NORMAL",
      "diurese" => "NORMAL",
      "obs" => "PACIENTE ESTA REAGINDO BEM",
      "medico" => "ANTONIO CARLOS PETRUS",
      "atendimento" => 99_999,
      "cd_paciente" => 88_888,
      "dt_assinatura" => "2020-04-29",
      "hospital_id" => "910a2168-b747-4c35-9c5e-74912c89213f"
    }
  end

  def bulletin_factory do
    %Bulletin{
      id: "caf4c454-3b3e-4426-b754-80eb69a68cee",
      nome: "Andre",
      dt_nascimento: "1977-01-28",
      geral: "ESTAVEL",
      pressao: "NORMAL",
      consciencia: "CONSCIENTE",
      febre: "Ausente",
      respiracao: "NORMAL",
      diurese: "NORMAL",
      obs: "PACIENTE ESTA REAGINDO BEM",
      medico: "ANTONIO CARLOS PETRUS",
      dt_assinatura: "2020-04-29",
      atendimento: 99_999,
      cd_paciente: 88_888,
      hospital_id: "b0a148c5-b40e-4476-8e86-efe90c9c4e28"
    }
  end
end
