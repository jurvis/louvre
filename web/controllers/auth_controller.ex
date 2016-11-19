defmodule Louvre.AuthController do
  use Louvre.Web, :controller

  alias Louvre.User

  def new(conn, %{"auth" => %{"email" => email}}) do
    user = Repo.one!(from u in User, where: u.email == ^email)

    auth_token = Base.encode16(:crypto.strong_rand_bytes(8))
    expires_at = Timex.shift(Timex.now, minutes: 15)

    changeset = User.auth_changeset(user, %{
      auth_token: auth_token,
      auth_token_expires_at: expires_at
    })

    case Repo.update(changeset) do
      {:ok, user} ->
        render conn, "new.html", person: user
      {:error, _} ->
        conn
        |> put_flash(:info, "try again!")
        |> render("new.html", person: nil)
    end
  end

  def new(conn, __params) do
    render conn, "new.html", person: nil
  end

  def create(conn, %{"token" => token}) do
    [email, auth_token] = User.decoded_auth(token)
    user = Repo.get_by(User, email: email, auth_token: auth_token)

    cond do
      user && Timex.before?(Timex.now, user.auth_token_expires_at) ->
        Repo.update(User.sign_in_changes(user))
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: admin_page_path(conn, :index))
      true ->
        conn
        |> put_flash(:info, "Whoops!")
        |> render "new.html", person: nil
    end
  end

  def delete(conn, __params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :home))
  end
end
