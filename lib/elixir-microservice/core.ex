defmodule ElixirMicroservice.Core do
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.Server
  use Application
  use Supervisor

  def start_link do
      Supervisor.start_link(__MODULE__, [])
    end

  def init([]) do
      children = [
        worker(AppStatus, []),
        worker(Server, [[:hello]])
      ]

      supervise(children, strategy: :one_for_one)
    end

  def start(_type, _args) do
      IO.puts "--> starting the microservice"
      start_link()
    end
end
