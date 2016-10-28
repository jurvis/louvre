defmodule Louvre.PageController do
  use Louvre.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
