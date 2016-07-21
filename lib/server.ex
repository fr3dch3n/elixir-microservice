defmodule MagellanMicroservice.Server do
  @moduledoc """
  This module handles the start-up sequence of the cowboy server.
  """

  use GenServer
  alias MagellanMicroservice.AppStatus
  alias MagellanMicroservice.Router
  require Logger

  @doc """
  This funtion tries to read the port, on which the server should run, from the config.
  As the log indicates the fallback is port 8080.
  """
  @spec specify_port() :: integer
  def specify_port() do
    try do
        raw = System.get_env("PORT")
        Logger.info raw
      {port,_} = Integer.parse(raw)
      Logger.info port
      port
    rescue
      _ in ArgumentError ->
        Logger.warn("No port specified. Falling back to 8080.")
        8080
    end
  end

  @doc """
  Ths function gets invoked by MagellanMicroservice.AppStatus.getStatus/0 and MagellanMicroservice.AppStatus.getHealth/0.
  It returns the current status of the module.
  """
  @spec status() :: %{atom => atom}
  def status() do
    %{status: :ok}
  end

  @doc """
  This start_link/0 function is invoked by the MagellanMicroservice.Core.start_link/0.
  It registers the status function status/0 and starts the server on the port specified by specify_port/0.
  """
  @spec start_link :: any()
  def start_link() do
    Logger.info "--> starting the magellan-server"
        port = specify_port()
        Logger.info port
        Logger.info is_binary(port)
        Logger.info is_integer(port)
    AppStatus.register_status_fun(:server, &status/0)

    Plug.Adapters.Cowboy.http(Router, [], port: port)
  end
end
