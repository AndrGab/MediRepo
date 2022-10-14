defmodule Medirepo.Factory do
  use ExMachina.Ecto, repo: Medirepo.Repo

  alias Medirepo.Bulletins.Models.Bulletin
  alias Medirepo.Hospitals.Models.Hospital

  def hospital_params_factory do
    %{
      "name" => "Hospital das Americas",
      "email" => "contato@hospital.com",
      "password" => "123456",
      "password_reset_token" => "abcdef"
    }
  end

  def hospital_factory do
    %Hospital{
      email: Faker.Internet.email(),
      password: "123456",
      name: Faker.Company.name(),
      id: Faker.UUID.v4()
    }
  end

  def bulletin_params_factory do
    %{
      "name" => "Andre",
      "dt_birth" => "1977-01-28",
      "general" => "ESTAVEL",
      "pressure" => "NORMAL",
      "conscience" => "CONSCIENTE",
      "fever" => "Ausente",
      "respiration" => "NORMAL",
      "diurese" => "NORMAL",
      "notes" => "PACIENTE ESTA REAGINDO BEM",
      "doctor" => "ANTONIO CARLOS PETRUS",
      "attendance" => 99_999,
      "cd_patient" => 88_888,
      "dt_signature" => "2020-04-29",
      "hospital_id" => "910a2168-b747-4c35-9c5e-74912c89213f"
    }
  end

  def bulletin_factory do
    %Bulletin{
      id: "caf4c454-3b3e-4426-b754-80eb69a68cee",
      name: "Andre",
      dt_birth: "1977-01-28",
      general: "ESTAVEL",
      pressure: "NORMAL",
      conscience: "CONSCIENTE",
      fever: "Ausente",
      respiration: "NORMAL",
      diurese: "NORMAL",
      notes: "PACIENTE ESTA REAGINDO BEM",
      doctor: "ANTONIO CARLOS PETRUS",
      dt_signature: "2020-04-29",
      attendance: 99_999,
      cd_patient: 88_888,
      hospital_id: "b0a148c5-b40e-4476-8e86-efe90c9c4e28"
    }
  end
end
