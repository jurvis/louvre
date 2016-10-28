defmodule Louvre.Router do
  use Louvre.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :put_layout, {Louvre.LayoutView, :admin}
  end

  scope "/", Louvre do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/admin", Louvre.Admin, as: :admin do
    pipe_through [:browser, :admin]

    get "/", PageController, :index
  end
end
