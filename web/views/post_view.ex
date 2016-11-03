defmodule Louvre.PostView do
  use Louvre.Web, :view
  
  def photo_url(photo, version), do: Louvre.Admin.PhotoView.photo_url(photo, version)
end
