defmodule Louvre.PageView do
  use Louvre.Web, :view

  alias Louvre.{PostView}

  def photo_url(photo, version), do: Louvre.Admin.PhotoView.photo_url(photo, version)
end
