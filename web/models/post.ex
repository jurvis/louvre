defmodule Louvre.Post do
  use Louvre.Web, :model

  alias Louvre.{Photo, Regexp}

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :vanity_domain, :string
    field :published, :boolean, default: false
    field :published_at, Ecto.DateTime

    has_many :photos, Photo, on_delete: :delete_all
    timestamps()
  end

  @required_fields ~w(title slug)
  @optional_fields ~w(vanity_domain published published_at)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:slug, Regexp.slug, message: Regexp.slug_message)
    |> validate_format(:vanity_domain, Regexp.http, message: Regexp.http_message)
    |> unique_constraint(:posts_slug_index)
  end

  def last_numbered_slug(post) do
    Repo.preload(post, :photos).photos
      |> Enum.sort_by(&(&1.id))
      |> Enum.reverse
      |> Enum.map(&(Float.parse(&1.slug)))
      |> Enum.find(fn(x) -> x != :error end)
  end
end
