defmodule Louvre.PageControllerTest do
  use Louvre.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Louvre!"
  end
end
