defmodule ImporterWeb.PageController do
  use ImporterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
