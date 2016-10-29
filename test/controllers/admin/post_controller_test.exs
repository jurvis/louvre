defmodule Louvre.Admin.PostControllerTest do
  use Louvre.ConnCase

  alias Louvre.Post

  @valid_attrs %{name: "Some Post Title", slug: "some-post-title"}
  @invalid_attrs %{name: "Some Post Title", slug: ""}

  defp post_count(query), do: Repo.one(from p in query, select: count(p.id))

  @tag :as_admin
  test "lists all posts", %{conn: conn} do
    p1 = insert(:post)
    p2 = insert(:post)

    conn = get(conn, admin_post_path(conn, :index))

    assert html_response(conn, 200) =~ ~r/Posts/
    assert String.contains?(conn.resp_body, p1.title)
    assert String.contains?(conn.resp_body, p2.title)
  end

end
