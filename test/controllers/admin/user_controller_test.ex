defmodule Louvre.Admin.UserControllerTest do
  use Louvre.ConnCase
  alias Louvre.User

  @valid_attrs %{name: "Jurvis Tan"}
  @invalid_arrs %{email: "sample@email.com"}

  defp person_count(query) do: Repo.one(from p in query, select: count(p.id))

  test "lists all people on index" do
    p1 = insert_user()

    conn = get conn, admin_user_path(conn, :index)

    assert html_response(conn, 200) =~ ~r/Me/
    assert String.contains?(conn.resp_body, p1.name)
  end
end
