defmodule Louvre.Admin.UserControllerTest do
  use Louvre.ConnCase

  @valid_attrs %{name: "Jurvis Tan"}
  @invalid_arrs %{email: "sample@email.com"}

  @tag :as_admin
  test "lists all people on index", %{conn: conn} do
    p1 = insert_user()

    conn = get conn, admin_user_path(conn, :index)

    assert html_response(conn, 200) =~ ~r/Me/
    assert String.contains?(conn.resp_body, p1.name)
  end

  test "requires user auth on all actions" do
    Enum.each([
      get(build_conn, admin_user_path(build_conn, :index))
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end
end
