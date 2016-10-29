alias Louvre.Repo
alias Louvre.User

import Ecto
import Ecto.Changeset
import Ecto.Query, only: [from: 1, from: 2]

defmodule H do
  def update(model, id, attrs \\ %{}) do
    Repo.update Ecto.Changeset.change(Repo.get(model, id), attrs)
  end
end
