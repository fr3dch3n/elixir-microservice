defmodule ElixirMicroservice.Server.Server do
  alias ElixirMicroservice.AppStatus, as: AppStatus
  alias ElixirMicroservice.Server.Router, as: Router
  use GenServer

  def start_link(state, opts \\ []) do
    IO.puts "--> starting the server"
    AppStatus.updateState("haha")
    Plug.Adapters.Cowboy.http(Router, [], port: 8080)
  end
end
