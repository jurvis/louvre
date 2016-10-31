defmodule Louvre.Admin.PhotoController do
  use Louvre.Web, :controller

  alias Louvre.{Post, Photo}

  plug :assign_post
  plug :scrub_params, "photo" when action in [:create, :update]

  # pass assigned post as a function arg
  def action(conn, _) do
    arg_list = [conn, conn.params, conn.assigns.post]
    apply __MODULE__, action_name(conn), arg_list
  end

  def index(conn, params, post) do
    photos = Photo
    |> where([p], p.post_id == ^post.id)
    |> Repo.all

    render conn, "index.html", photos: photos
  end

  def new(conn, _params, post) do
    default_slug = case Post.last_numbered_slug(post) do
      {float, _} -> round(Float.floor(float) + 1)
      _ -> ""
    end

    changeset =
      post
      |> build_assoc(:photos,
        slug: default_slug)
      |> Photo.changeset

    render conn, "new.html", changeset: changeset
  end

  def create(conn, params = %{"photo" => photo_params}, post) do
    changeset =
      build_assoc(post, :photos)
      |> Photo.changeset(photo_params)

    case Repo.insert(changeset) do
      {:ok, episode} ->
        conn
        |> put_flash(:result, "success")
        |> redirect(to: admin_post_photo_path(conn, :index, post.slug))
      {:error, changeset} ->
        conn
        |> put_flash(:result, "failure")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => slug}, post) do
    photo =
      assoc(post, :photos)
      |> Repo.get_by!(slug: slug)

    changeset = Photo.changeset(photo)
    render conn, "edit.html", photo: photo, changeset: changeset
  end

  def update(conn, params = %{"id" => slug, "photo" => photo_params}, post) do
    photo =
      assoc(post, :photos)
      |> Repo.get_by!(slug: slug)

    changeset = Photo.changeset(photo, photo_params)

    case Repo.update(changeset) do
      {:ok, photo} ->
        conn
        |> put_flash(:result, "success")
        |> redirect(to: admin_post_photo_path(conn, :index, post.slug))
      {:error, changeset} ->
        conn
        |> put_flash(:result, "failure")
        |> render("edit.html", photo: photo, changeset: changeset)
    end
  end

  defp assign_post(conn, _) do
    post = Repo.get_by!(Post, slug: conn.params["post_id"])
    assign conn, :post, post
  end

end
