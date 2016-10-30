defmodule Louvre.Admin.PostView do
  use Louvre.Web, :view

  import Louvre.Admin.SharedView, only: :functions

  def vanity_link(podcast) do
    if podcast.vanity_domain do
      external_link podcast.vanity_domain, to: podcast.vanity_domain
    end
  end
end
