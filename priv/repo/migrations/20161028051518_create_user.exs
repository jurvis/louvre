defmodule Louvre.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :auth_token, :string
      add :auth_token_expires_at, :datetime
      add :signed_in_at, :datetime
      timestamps()
    end

    create unique_index(:users, [:name])
    create unique_index(:users, [:email])
  end
end
