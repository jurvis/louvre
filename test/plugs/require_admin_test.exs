defmodule Louvre.RequireAdminTest do
  use Louvre.ConnCase

  setup _config do
    conn =
      build_conn
      |> bypass_through(Louvre.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  test "it halts when no user is assigned", %{conn: conn} do
    conn = Louvre.Plug.RequireAdmin.call(conn, [])
    assert conn.halted
  end
end
