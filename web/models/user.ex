defmodule Louvre.User do
  use Louvre.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :auth_token, :string
    field :auth_token_expires_at, Ecto.DateTime
    field :signed_in_at, Ecto.DateTime
    timestamps()
  end

  @required_fields ~w(name)
  @optional_fields ~w(email)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([])
    |> unique_constraint(:name)
    |> unique_constraint(:email)
  end
end
