defmodule Louvre.PageController do
  use Louvre.Web, :controller

  alias Louvre.{Post}

  def home(conn, _params) do
    posts = Repo.all(from p in Post, where: p.published == true)
      |> Enum.reverse
      |> Post.preload_photos
    render conn, "home.html", posts: posts
  end
end
