defmodule Louvre.Admin.PageControllerTest do
  use Louvre.ConnCase

  test "GET /" do
    conn = get conn(), "/admin"
    assert html_response(conn, 200) =~ "Admin"
  end
end
