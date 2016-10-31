defmodule Louvre.PhotoTest do
  use Louvre.ModelCase

  alias Louvre.Photo

  @valid_attrs %{caption: "Great Photo!", slug: "great-photo"}
  @invalid_attrs %{slug: ""}

  test "changeset with valid attributes" do
    changeset = Photo.changeset(%Photo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Photo.changeset(%Photo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
