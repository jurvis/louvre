defmodule Louvre.Repo.Migrations.CreatePhoto do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :caption, :string
      add :slug, :string, null: false
      add :image_file, :string
      add :post_id, references(:posts)
      timestamps()
    end

    create index(:photos, [:post_id])
    create unique_index(:photos, [:slug, :post_id])
  end
end
