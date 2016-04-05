defmodule ElixirMicroservice.Server.Router do
  use Plug.Router
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.RouterHelper

  require EEx

  plug :match
  plug :dispatch

  def init([]) do
    IO.puts "--> starting magellan-router"
  end

  get "/health" do
    send_resp(conn, 200, "OK")
  end

  get "/status" do
    send_resp(conn, 200, "status")
  end

  forward "/", to: Application.fetch_env!(:router, :app_router)
end
