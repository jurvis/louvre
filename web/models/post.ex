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

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :slug, :vanity_domain, :published, :published_at])
    |> validate_required([:title, :slug])
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

  def photos_count(post) do
    Repo.preload(post, :photos).photos
    |> Enum.count
  end

  def preload_photos(post) do
    post
    |> Repo.preload(:photos)
  end

  def published(query \\ __MODULE__) do
    from p in query, where: p.published == true
  end

  def unpublished(query \\ __MODULE__) do
    from p in query, where: p.published == false
  end
end
