defmodule MagellanMicroservice.Server.Server do
  alias MagellanMicroservice.AppStatus, as: AppStatus
  alias MagellanMicroservice.Server.Router, as: Router
  require Logger
  use GenServer

  def specify_port() do
    try do
      Application.fetch_env!(:microservice, :port)
    rescue
      _ in ArgumentError ->
        Logger.warn("No port specified. Falling back to 8080.")
        8080
    end
  end

  def status() do
    %{status: :ok}
  end

  def start_link() do
    Logger.info "--> starting the magellan-server"
    AppStatus.registerStatusFun(:server, &status/0)
    Plug.Adapters.Cowboy.http(Router, [], port: specify_port)
  end
end
