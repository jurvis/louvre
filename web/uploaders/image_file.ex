defmodule Louvre.ImageFile do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb, :small, :medium, :large]

  @widths %{
    thumb: 30,
    small: 750,
    medium: 1024,
    large: 2048
  }

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .JPG .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail #{@widths[:thumb]}x#{@widths[:thumb]}^ -gravity center -extent #{@widths[:thumb]}x#{@widths[:thumb]} -format png", :png}
  end

  def transform(:small, _) do
    {:convert, "-strip -resize #{@widths[:small]}x"}
  end

  # Define a medium transformation:
  def transform(:medium, _) do
    {:convert, "-strip -resize #{@widths[:medium]}x",}
  end

  def transform(:large, _) do
    {:convert, "-strip -resize #{@widths[:large]}x",}
  end

  # Override the persisted filenames:
  def filename(version, {file, scope}) do
    "#{scope.post_id}_#{version}_#{file.file_name}"
  end

  # Override the storage directory:
  def storage_dir(version, {_file, scope}) do
    "uploads/images/#{scope.post_id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  def s3_object_headers(_, {file, _}) do
    [content_type: Plug.MIME.path(file.file_name)]
  end
end
