defmodule Louvre.AuthControllerTest do
  use Louvre.ConnCase

  alias Louvre.User

  def valid_expires_at do
    Timex.now |> Timex.add(Timex.Duration.from_minutes(15))
  end

  def invalid_expires_at do
    Timex.now |> Timex.subtract(Timex.Duration.from_minutes(15))
  end

  test "getting the sign in form" do
    conn = get build_conn(), "/in"
    assert html_response(conn, 200) =~ "Sign In"
  end

  test "submitting the form with known email sets auth token and sends email" do
    user = insert(:user, auth_token: nil)

    conn = post build_conn(), "/in", auth: %{email: user.email}
    user = Repo.get(User, user.id)

    assert html_response(conn, 200) =~ "Check your email"
    assert user.auth_token != nil
  end

  test "following a valid auth token signs you in" do
    user = insert(:user)

    changeset = User.auth_changeset(user, %{
      auth_token: "12345",
      auth_token_expires_at: valid_expires_at()
    })

    {:ok, user} = Repo.update(changeset)
    {:ok, encoded} = User.encoded_auth(user)

    conn = get(build_conn, "/in/#{encoded}")

    assert redirected_to(conn) == admin_page_path(conn, :index)
    assert get_session(conn, :user_id) == user.id
  end

  test "following an expired token doesn't sign you in" do
    user = insert(:user)

    changeset = User.auth_changeset(user, %{
      auth_token: "12345",
      auth_token_expires_at: invalid_expires_at()
    })

    {:ok, user} = Repo.update(changeset)
    {:ok, encoded} = User.encoded_auth(user)

    conn = get build_conn(), "/in/#{encoded}"

    assert html_response(conn, 200) =~ "Sign In"
    refute get_session(conn, :user_id) == user.id
  end
end
