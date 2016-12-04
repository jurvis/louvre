defmodule Louvre.PostController do
  use Louvre.Web, :controller

  alias Louvre.Post

  def show(conn, %{"id" => slug}) do
    post = Repo.get_by!(Post, slug: slug, published: true)
      |> Post.preload_photos
    render conn, "show.html", post: post
  end
end
