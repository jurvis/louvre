defmodule Louvre.Photo do
  use Louvre.Web, :model
  use Arc.Definition
  use Arc.Ecto.Schema

  alias Louvre.Regexp

  schema "photos" do
    field :caption, :string
    field :slug, :string
    field :order_id, :integer
    field :layout, :float

    field :image_file, Louvre.ImageFile.Type

    belongs_to :post, Louvre.Post
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:slug, :layout, :caption, :order_id])
    |> validate_required([:slug, :order_id])
    |> cast_attachments(params, [:image_file])
    |> validate_format(:slug, Regexp.slug, message: Regexp.slug_message)
    |> unique_constraint(:photos_slug_post_id_index)
  end

end
