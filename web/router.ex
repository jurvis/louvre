defmodule Louvre.Router do
  use Louvre.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Louvre.Plug.Auth, repo: Louvre.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :put_layout, {Louvre.LayoutView, :admin}
    plug Louvre.Plug.RequireAdmin
  end

  scope "/", Louvre do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/in", AuthController, :new, as: :sign_in
    post "/in", AuthController, :new, as: :sign_in
    get "/in/:token", AuthController, :create, as: :create_sign_in
    get "/out", AuthController, :delete, as: :sign_out
  end

  scope "/admin", Louvre.Admin, as: :admin do
    pipe_through [:browser, :admin]

    get "/", PageController, :index
    resources "/me", UserController
  end
end
