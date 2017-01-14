defmodule Louvre.Repo.Migrations.AddLayoutAndOrderToPhoto do
  use Ecto.Migration

  alias Louvre.{Post, Photo, Repo}

  def change do
    alter table(:photos) do
      add :order_id, :integer
      add :layout, :float, default: 1.0
    end
  end
end
