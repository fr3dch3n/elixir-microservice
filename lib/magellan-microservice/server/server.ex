defmodule ElixirMicroservice.Server.Server do
  alias ElixirMicroservice.AppStatus, as: AppStatus
  alias ElixirMicroservice.Server.Router, as: Router
  use GenServer
  require Logger

  def start_link() do
    Logger.info "--> starting the server"
    AppStatus.updateState(%{server: :ok})
    Plug.Adapters.Cowboy.http(Router, [], port: 8080)
  end
end
