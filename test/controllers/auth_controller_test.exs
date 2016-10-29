defmodule Louvre.AuthControllerTest do
  use Louvre.ConnCase

  alias Louvre.User

  def valid_expires_at do
    Timex.now |> Timex.Date.add(Timex.Time.to_timestamp(15, :mins))
  end

  def invalid_expires_at do
    Timex.now |> Timex.Date.subtract(Timex.Time.to_timestamp(15, :mins))
  end

  test "getting the sign in form" do
    conn = get conn(), "/in"
    assert html_response(conn, 200) =~ "Sign In"
  end

  test "submitting the form with known email sets auth token and sends email" do
    user = insert_user(auth_token: nil)

    conn = post conn(), "/in", auth: %{email: user.email}
    user = Repo.get(User, user.id)

    assert html_response(conn, 200) =~ "Check your email"
    assert person.auth_token != nil
  end

  test "following a valid auth token signs you in" do
    user = insert_user()
    changeset = User.auth_changeset(user, %{
      auth_token: "12345",
      auth_token_expires_at: valid_expires_at
    })

    {:ok, person} = Repo.update(changeset)
    {:ok, encoded} = User.encoded_auth(user)

    conn = get conn(), "/in/#{encoded}"

    assert redirected_to(conn) == page_path(conn, :index)
    assert get_session(conn, :user_id) == user.id
  end

  test "following an expired token doesn't sign you in" do
    user = insert_user()

    changeset = User.auth_changeset(user, %{
      auth_token: "12345",
      auth_token_expires_at: invalid_expires_at()
    })

    {:ok, person} = Repo.update(changeset)
    {:ok, encoded} = User.encoded_auth(user)

    conn = get conn(), "/in/#{encoded}"

    assert html_response(conn, 200) =~ "Sign In"
    refute get_session(conn, :user_id) == user.id
  end

  test "you can sign out" do
    out_conn =
    conn
    |> put_session(:user_id, 123)
    |> get sign_out_path(conn, :delete)

    assert redirected_to(out_conn) == page_path(out_conn, :index)

    next_conn = get(out_conn, "/")
    refute get_session(next_conn, :user_id)
  end
end
