defmodule MedirepoWeb.Schema.Mutation.HospitalsTest do
  use MedirepoWeb.ConnCase, async: true

  import Medirepo.Factory

  @query """
  mutation ($hospital: HospitalInput!) {
    createHospital(input: $hospital) {
      name
      email
      id
    }
  }
  """

  test "successfully creates a new hospital" do
    %{"email" => email, "name" => name} = hospital_params = hospital_params_factory()

    conn = build_conn()

    conn = post conn, "/api/graphql", query: @query, variables: %{"hospital" => hospital_params}

    assert %{
             "data" => %{
               "createHospital" => %{
                 "name" => ^name,
                 "email" => ^email,
                 "id" => _id
               }
             }
           } = json_response(conn, 200)
  end
end
