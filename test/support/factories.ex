defmodule Louvre.Factories do
  alias Louvre.Repo
  alias Louvre.User

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Jurvis Tan #{Base.encode16(:crypto.strong_rand_bytes(8))}",
      email: "test#{Base.encode16(:crypto.strong_rand_bytes(8))}@email.com"
    }, attrs)

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!
  end
end
