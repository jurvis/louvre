defmodule Louvre.AuthView do
  use Louvre.Web, :view
  alias Louvre.User

  def auth_path(user) do
    {:ok, encoded} = User.encoded_auth(user)
    "/in/#{encoded}"
  end
end
