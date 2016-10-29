defmodule Louvre.Admin.PostController do
  use Louvre.Web, :controller

  alias Louvre.Post

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    posts = Repo.all from p in Post, order_by: p.id
    render conn, "index.html", posts: posts
  end
end
