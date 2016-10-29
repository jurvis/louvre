defmodule Louvre.Factory do
  use ExMachina.Ecto, repo: Louvre.Repo

  def user_factory do
    %Louvre.User{
      name: sequence(:name, &"Jurvis Tan #{&1}"),
      email: sequence(:email, &"jurvis-#{&1}@email.com")
    }
  end
end
