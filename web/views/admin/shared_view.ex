defmodule Louvre.Admin.SharedView do
  use Phoenix.HTML

  def semantic_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      ~e"""
      <div class="fields">
        <div class="three wide field"><%= b.(:month, []) %></div>
        <div class="two wide field"><%= b.(:day, []) %></div>
        <div class="two wide field"><%= b.(:year, [options: 2008..2025]) %></div> at
        <div class="two wide field"><%= b.(:hour, []) %></div>:
        <div class="two wide field"><%= b.(:minute, []) %></div>&nbsp;UTC
      </div>
      """
    end

    datetime_select form, field, [builder: builder] ++ opts
  end

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

  def form_actions do
    ~e"""
    <button class="ui primary basic button" type="submit">Save</button>
    <button class="ui secondary basic button" type="submit" name="close">Save and Close</button>
    """
  end
end
