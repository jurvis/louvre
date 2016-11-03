defmodule Louvre.Admin.PhotoView do
  use Louvre.Web, :view

  import Louvre.Admin.SharedView

  def photo_url(photo, version) do
    if photo.image_file do
      Louvre.Photo.url({photo.image_file, photo}, version)
    end
  end
end
