defmodule Louvre.Admin.PostControllerTest do
  use Louvre.ConnCase

  alias Louvre.Post

  @valid_attrs %{title: "Some Post Title", slug: "some-post-title"}
  @invalid_attrs %{title: "Some Post Title", slug: ""}

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

  @tag :as_admin
  test "renders form to create post", %{conn: conn} do
    conn = get(conn, admin_post_path(conn, :new))
    assert html_response(conn, 200) =~ ~r/New/
  end

  @tag :as_admin
  test "creates post and then redirects", %{conn: conn} do
    conn = post(conn, admin_post_path(conn, :create), post: @valid_attrs)

    assert redirected_to(conn) == admin_post_path(conn, :index)
    assert post_count(Post) == 1
  end

  @tag :as_admin
  test "does not create with invalid attributes", %{conn: conn} do
    count_before = post_count(Post)
    conn = post(conn, admin_post_path(conn, :create), post: @invalid_attrs)

    assert html_response(conn, 200) =~ ~r/error/
    assert post_count(Post) == count_before
  end

  @tag :as_admin
  test "renders form to edit posts", %{conn: conn} do
    post = insert(:post)
    conn = get(conn, admin_post_path(conn, :edit, post))

    assert html_response(conn, 200) =~ ~r/edit/i
  end

  @tag :as_admin
  test "updates post and redirects", %{conn: conn} do
    post = insert(:post)
    count_before = post_count(Post)

    conn = put(conn, admin_post_path(conn, :update, post.id), post: @valid_attrs)

    assert redirected_to(conn) == admin_post_path(conn, :index)
    assert post_count(Post) == count_before
  end

  @tag :as_admin
  test "does not update with invalid attributes", %{conn: conn} do
    post = insert(:post)
    count_before = post_count(Post)

    conn = put(conn, admin_post_path(conn, :update, post.id), post: @invalid_attrs)

    assert html_response(conn, 200) =~ ~r/error/
    assert post_count(Post) == count_before
  end

end
