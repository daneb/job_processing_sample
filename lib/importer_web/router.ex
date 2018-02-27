defmodule ImporterWeb.Router do
  use ImporterWeb, :router

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

  pipeline :exq do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug ExqUi.RouterPlug, namespace: "exq"
  end

  scope "/", ImporterWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/runner", RunnerController, except: [:new, :edit]
  end

  scope "/exq", ExqUi do
    pipe_through(:exq)
    forward "/", RouterPlug.Router, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ImporterWeb do
  #   pipe_through :api
  # end
end
