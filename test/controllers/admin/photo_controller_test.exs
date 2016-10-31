defmodule Louvre.Admin.PhotoControllerTest do
  use Louvre.ConnCase

  alias Louvre.Photo

  @valid_attrs %{caption: "sample", slug: "ftw"}
  @invalid_attrs %{}

  @tag :as_admin
  test "show all photos on index", %{conn: conn} do
    post = insert(:post)
    photo1 = insert(:photo, post: post)
    photo2 = insert(:photo)

    conn = get(conn, admin_post_photo_path(conn, :index, post.slug))
    assert html_response(conn, 200) =~ ~r/posts/i
    assert String.contains?(conn.resp_body, post.title)
    assert String.contains?(conn.resp_body, photo1.caption)
    refute String.contains?(conn.resp_body, photo2.caption)
  end

  @tag :as_admin
  test "renders form to add new photo", %{conn: conn} do
    post = insert(:post)

    conn = get(conn, admin_post_photo_path(conn, :new, post.slug))
    assert html_response(conn, 200) =~ ~r/new photo/i
  end
end
