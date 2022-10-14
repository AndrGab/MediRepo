# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Medirepo.Repo.insert!(%Medirepo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Medirepo.Bulletins.Models.Bulletin
alias Medirepo.Hospitals.Models.Hospital
alias Medirepo.Repo

changeset =
  Hospital.changeset(
    %Hospital{},
    %{
      "name" => "Hospital das Americas",
      "email" => "contato@hospital.com",
      "password" => "123456",
      "password_reset_token" => "abcdef"
    }
  )

hospital = Repo.insert!(changeset)

changeset =
  Hospital.changeset(
    %Hospital{},
    %{
      "name" => "Presbyterian",
      "email" => "contact@presbyterian.com",
      "password" => "123456",
      "password_reset_token" => "abcdef"
    }
  )

hospital2 = Repo.insert!(changeset)

changeset =
  Hospital.changeset(
    %Hospital{},
    %{
      "name" => "Lovelace",
      "email" => "contat@lovelace.com",
      "password" => "123456",
      "password_reset_token" => "abcdef"
    }
  )

Repo.insert!(changeset)

changeset =
  Bulletin.changeset(
    %Bulletin{},
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
      "hospital_id" => hospital.id
    }
  )

Repo.insert!(changeset)

changeset =
  Bulletin.changeset(
    %Bulletin{},
    %{
      "name" => "Randy",
      "dt_birth" => "1983-12-22",
      "general" => "ESTAVEL",
      "pressure" => "HIGH",
      "conscience" => "UNCONSCIENCE",
      "fever" => "YES",
      "respiration" => "BELABORED",
      "diurese" => "NORMAL",
      "notes" => "PATIENT IS HAVE SOME DIFFICULTY BREATHING AND HAS A FEVER",
      "doctor" => "DR DRACULA",
      "attendance" => 99_999,
      "cd_patient" => 88_888,
      "dt_signature" => "2020-08-17",
      "hospital_id" => hospital2.id
    }
  )

Repo.insert!(changeset)
