defmodule Louvre.User do
  use Louvre.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :auth_token, :string
    field :auth_token_expires_at, Timex.Ecto.DateTime
    field :signed_in_at, Timex.Ecto.DateTime
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

  def auth_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(auth_token auth_token_expires_at), [])
  end

  def sign_in_changes(model) do
    change(model, %{
      auth_token: nil,
      auth_token_expires_at: nil,
      signed_in_at: Timex.now
    })
  end

  def signed_in(model, datetime) do
  end

  def encoded_auth(model) do
    {:ok, Base.encode16("#{model.email}|#{model.auth_token}")}
  end

  def decoded_auth(encoded) do
    {:ok, decoded} = Base.decode16(encoded)
    String.split(decoded, "|")
  end
end
