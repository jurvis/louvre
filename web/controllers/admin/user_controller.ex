defmodule Louvre.Admin.UserController do
  use Louvre.Web, :controller

  alias Louvre.User

  def index(conn, _params) do
    person = Repo.one(User, limit: 1)
    render conn, "index.html", person: person
  end
end
