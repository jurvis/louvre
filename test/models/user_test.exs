defmodule Louvre.UserTest do
  use Louvre.ModelCase

  alias Louvre.User

  @valid_attrs %{name: "Jurvis Tan", email: "hello@jurvis.co"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "encoded_auth and decoded_auth" do
    user = %User{email: "jane@doe.com", auth_token:"8675309"}

    {:ok, encoded} = User.encoded_auth(user)

    assert encoded == "6A656E6E7940686974732E636F6D7C38363735333039"
    assert ["jane@doe.com", "8675309"] = User.decoded_auth(encoded)
  end
end
