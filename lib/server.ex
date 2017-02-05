defmodule MagellanMicroservice.Server do
  @moduledoc """
  This module handles the start-up sequence of the server which uses cowboy and plug.
  """

  use GenServer
  alias MagellanMicroservice.AppStatus
  alias MagellanMicroservice.Router
  require Logger

  @doc """
  This funtion tries to read the port, on which the server should run, from the environment variable `PORT`.
  As the log indicates the fallback is port `8080`.
  """
  @spec specify_port() :: integer
  def specify_port() do
    try do
      {port,_} = Integer.parse(System.get_env("PORT"))
      port
    rescue
      _ in ArgumentError ->
        Logger.warn("No port specified. Falling back to 8080.")
        8080
    end
  end

  @doc """
  Ths function gets invoked by `MagellanMicroservice.AppStatus.get_status/0` and `MagellanMicroservice.AppStatus.get_health/0`.
  It returns the current status of the module.
  """
  @spec status() :: %{atom => atom}
  def status() do
    %{status: :ok}
  end

  @doc """
  This `start_link/0` function is invoked by the `MagellanMicroservice.start_link/0`.
  It registers the status function `status/0` and starts the server on the port specified by `specify_port/0`.
  """
  @spec start_link :: any()
  def start_link() do
    port = specify_port()
    Logger.info "--> starting the magellan-server on port " <> Integer.to_string(port)
    AppStatus.register_status_fun(:server, &status/0)
    process = Plug.Adapters.Cowboy.http(Router, [], port: port)
    Logger.info "<-- magellan-server started on port " <> Integer.to_string(port)
    process
  end
end
