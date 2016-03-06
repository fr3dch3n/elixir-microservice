defmodule ElixirMicroservice.AppStatus do

  def start_link() do
    IO.puts "--> starting the app-status"
    Agent.start_link(fn -> %{:status => :ok} end, name: __MODULE__)
  end

  def updateState(state) do
    newStatus = %{:status => :ok, :server => :ok}
    # state mergen und/oder updaten
    Agent.update(__MODULE__, fn(_n) -> newStatus end)
  end

  def getStatus() do
    Agent.get(__MODULE__, fn(n) -> n end)
  end

  def getJsonState() do
    Poison.Encoder.encode(getStatus, [])
  end
end
