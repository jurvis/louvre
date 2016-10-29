defmodule Louvre.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :published, :boolean, default: false
      add :published_at, :datetime
      timestamps()
    end

    create unique_index(:posts, [:slug])
  end
end
