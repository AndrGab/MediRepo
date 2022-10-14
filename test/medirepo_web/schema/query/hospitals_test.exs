defmodule MedirepoWeb.Schema.Query.HospitalsTest do
  use MedirepoWeb.ConnCase, async: true

  import Medirepo.Factory

  setup do
    setup_hospitals()
  end

  @query """
  {
    hospitals {
      name
      id
    }
  }
  """
  test "hospitals returns all the hospitals", %{hospitals: expected_hospitals} do
    conn = build_conn()
    conn = get(conn, "/api/graphql", query: @query)

    expected_hospitals =
      Enum.map(expected_hospitals, fn %{name: name, id: id} ->
        %{"name" => name, "id" => id}
      end)

    %{
      "data" => %{
        "hospitals" => hospitals
      }
    } = json_response(conn, 200)

    assert expected_hospitals == hospitals
  end

  defp setup_hospitals do
    hospitals = insert_list(3, :hospital)

    {:ok, hospitals: hospitals}
  end
end
