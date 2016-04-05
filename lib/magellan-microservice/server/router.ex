defmodule ElixirMicroservice.Server.Router do
  use Plug.Router
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.RouterHelper

  require EEx
  require Logger

  plug :match
  plug :dispatch



  def init([]) do
    Logger.info("--> starting magellan-router")
    try do
      Application.fetch_env!(:microservice, :app_router)
    rescue e in ArgumentError -> Logger.warn("No custom router specified.")
    end
  end

  get "/health" do
    send_resp(conn, 200, "OK")
  end

  get "/status" do
    send_resp(conn, 200, "status")
  end
  try do
    forward "/", to: Application.fetch_env!(:microservice, :app_router)
  rescue e in ArgumentError -> Logger.warn("No custom router specified.")
  end



  match _ do
    send_resp(conn, 404, "Invalide URL because of no router defined.")
  end


end
