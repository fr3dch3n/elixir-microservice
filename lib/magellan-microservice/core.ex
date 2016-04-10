defmodule MagellanMicroservice.Core do
  alias MagellanMicroservice.AppStatus
  alias MagellanMicroservice.Server.Server
  require Logger
  use Application
  use Supervisor

  def start_link do
      Supervisor.start_link(__MODULE__, [])
    end

  def init([]) do
      children = [
        worker(MagellanMicroservice.Config, []),
        worker(AppStatus, []),
        worker(Server, [])
      ]

      supervise(children, strategy: :one_for_one)
    end

  def start(_type, _args) do
      Logger.info "--> starting the magellan-microservice"
      start_link()
    end
end
