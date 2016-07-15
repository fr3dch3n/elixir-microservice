defmodule MagellanMicroservice.Core do
  @moduledoc """
  This module contains the children of the Magellan-Microservice and is responsible for starting them up.
  """

  use Application
  use Supervisor
  alias MagellanMicroservice.AppStatus
  alias MagellanMicroservice.Server
  require Logger

  @doc """
  Invoking Supervisor.start_link/2 will result in a call to init/1.
  Refer to Supervisor.start_link documentation.
  """
  @spec start_link :: any()
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  @doc """
  The children MagellanMicroservice.AppStatus and MagellanMicroservice.Server are started up via its own start_link/1 function.
  """
  @spec init([]) :: any()
  def init([]) do
    children = [
      worker(AppStatus, []),
      worker(Server, [])
    ]
    supervise(children, strategy: :one_for_one)
  end

  @doc """
  This function is the entrypoint of the MagellanMicroserivce.
  """
  @spec start(any, any) :: any()
  def start(_type, _args) do
    Logger.info "--> starting the magellan-microservice"
    start_link()
  end
end