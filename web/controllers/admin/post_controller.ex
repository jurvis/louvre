defmodule Louvre.Admin.PostController do
  use Louvre.Web, :controller

  alias Louvre.Post

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    posts = Repo.all from p in Post, order_by: p.id
    render conn, "index.html", posts: posts
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:result, "#{post.title} created!")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:result, "failure")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, params = %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)

    render conn, "edit.html", post: post, changeset: changeset
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "#{post.title} updated!")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", post: post, changeset: changeset
    end
  end
end
