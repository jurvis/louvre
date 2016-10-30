defmodule Louvre.Admin.SharedView do
  use Phoenix.HTML

  def error_class(form, field) do
    if form.errors[field], do: "error", else: ""
  end

  def error_message(form, field) do
    case form.errors[field] do
      {message, _} ->
        content_tag :div, class: "ui pointing red basic label" do
          message
        end
      nil -> ""
    end
  end
end
