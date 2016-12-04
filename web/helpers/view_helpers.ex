defmodule Louvre.Helpers.ViewHelpers do
  use Phoenix.HTML

  defmacro __using__(_) do
    quote do
      import Louvre.Helpers.ViewHelpers
    end
  end

  def domain_only(url) do
    uri = URI.parse(url)
    uri.host
  end

  def external_link(text, opts) do
    link text, (opts ++ [rel: "external"])
  end

  def truncate(string, length) when is_binary(string) do
    if String.length(string) > length do
      String.slice(string, 0, length) <> "..."
    else
      string
    end
  end
end
