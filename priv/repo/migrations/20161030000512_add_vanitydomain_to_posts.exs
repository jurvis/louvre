defmodule Louvre.Repo.Migrations.AddVanitydomainToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :vanity_domain, :string
    end
  end
end
