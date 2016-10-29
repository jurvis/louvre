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
end
