defmodule Louvre.Admin.PostView do
  use Louvre.Web, :view

  import Louvre.Admin.SharedView, only: :functions

  def status_label(post) do
    if post.published do
      content_tag :span, "Published", class: "ui tiny green basic label"
    else
      content_tag :span, "Draft", class: "ui tiny yellow basic label"
    end
  end

  def vanity_link(post) do
    if post.vanity_domain do
      external_link post.vanity_domain, to: post.vanity_domain
    end
  end
end
