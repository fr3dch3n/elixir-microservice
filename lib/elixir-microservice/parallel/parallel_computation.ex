defmodule ElixirMicroservice.Parallel.Worker do
  use GenServer

  def start_link(state) do
    :gen_server.start_link(__MODULE__, state, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:greet, from, state) do
    :timer.sleep(1000)
    {:reply, "Hello fromme #{inspect self}", state}
  end
end
