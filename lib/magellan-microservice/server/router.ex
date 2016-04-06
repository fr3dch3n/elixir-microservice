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
    try do
      Application.fetch_env!(:magellan_microservice, :app_router)
    rescue
      _ in ArgumentError ->
        Logger.warn("No custom router specified.")
    end
  end

  get "/health" do
    send_resp(conn, 200, AppStatus.getHealth)
  end

  get "/status" do
    send_resp(conn, 200, AppStatus.getJsonState)
  end

  #TODO: prettystatus with eex

  try do
    IO.inspect Application.fetch_env!(:magellan_microservice, :app_router)
    forward "/", to: Application.fetch_env!(:magellan_microservice, :app_router)
  rescue
    _ in ArgumentError ->
      Logger.warn("No custom router specified.")
  end

  match _ do
    send_resp(conn, 404, "Invalide URL because of no router defined.")
  end
end
