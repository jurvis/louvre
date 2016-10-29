defmodule Louvre.Factories do
  alias Louvre.Repo
  alias Louvre.User

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Jurvis Tan #{Base.encode16(:crypto.rand_bytes(8))}"
    }, attrs)

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!
  end
end
