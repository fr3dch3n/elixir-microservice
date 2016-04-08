defmodule MagellanMicroservice.Server.Router do
  alias MagellanMicroservice.AppStatus
  require EEx
  require Logger
  use Plug.Router

  plug :match
  plug :dispatch

  def status() do
    %{status: :ok}
  end

  def init([]) do
    Logger.info("--> starting the magellan-router")
    AppStatus.registerStatusFun(:router, &status/0)
    Agent.start_link(fn ->
    []
   end, name: __MODULE__)
  end

  def registerRouter(x) do
    Agent.update(__MODULE__, fn(_n) -> x end)
  end

  def getStatus() do
    Agent.get(__MODULE__, fn(n) ->
      n
    end)
  end

  get "/health" do
    send_resp(conn, 200, AppStatus.getHealth)
  end

  get "/status" do
    send_resp(conn, 200, AppStatus.getJsonState)
  end

  match _ do
    n = getStatus
    if Enum.empty?(n) do
      Logger.warn "No custom router defined!"
      send_resp(conn, 404, "Invalide URL.")
    else
       n.call(conn, [])
    end
  end
end
