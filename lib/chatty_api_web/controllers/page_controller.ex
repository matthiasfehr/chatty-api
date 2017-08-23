defmodule ChattyApiWeb.PageController do
  use ChattyApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
