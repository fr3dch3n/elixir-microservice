defmodule ElixirMicroservice.Server.Router do
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.RouterHelper
  require EEx

  def init(default_opts) do
    IO.puts "--> starting the router"
    default_opts
  end
  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end
  def route("GET", ["status"], conn) do
   conn |> Plug.Conn.send_resp(200, AppStatus.getJsonState)
  end
  def route(_method, _path, conn) do
      conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
  end
end
