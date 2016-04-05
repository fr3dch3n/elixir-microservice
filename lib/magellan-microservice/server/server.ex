defmodule MagellanMicroservice.Server.Server do
  alias MagellanMicroservice.AppStatus, as: AppStatus
  alias MagellanMicroservice.Server.Router, as: Router
  require Logger
  use GenServer

  def specify_port() do
    try do
      Application.fetch_env!(:microservice, :port)
    rescue
      e in ArgumentError ->
        Logger.warn("No port specified. Falling back to 8080.")
        8080
    end
  end

  def start_link() do
    Logger.info "--> starting the magellan-server"
    AppStatus.updateState(%{server: :ok})
    Plug.Adapters.Cowboy.http(Router, [], port: specify_port)
  end
end
