defmodule Louvre.PostView do
  use Louvre.Web, :view

  def photo_url(conn, photo) do
    # TODO: I don't fancy the imperative approach here, will change eventually.
    cond do
      Browser.mobile?(conn) ->
        Louvre.Admin.PhotoView.photo_url(photo, :medium)
      Browser.tablet?(conn) ->
        Louvre.Admin.PhotoView.photo_url(photo, :large)
      true ->
        Louvre.Admin.PhotoView.photo_url(photo, :original)
    end
  end
end
