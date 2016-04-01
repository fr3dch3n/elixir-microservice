defmodule MagellanMicroservice.PageController do
  use MagellanMicroservice.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
