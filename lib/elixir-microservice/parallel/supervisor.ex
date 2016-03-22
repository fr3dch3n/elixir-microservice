defmodule ElixirMicroservice.Parallel.Par_Supervisor do
  alias ElixirMicroservice.Parallel.Worker
  use Supervisor

  def start_link do
    IO.puts "--> starting parallel computation"
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    # Here are my pool options
    pool_options = [
      name: {:local, :hello_pool},
      worker_module: Worker,
      size: 5,
      max_overflow: 10
    ]

    children = [
      :poolboy.child_spec(:hello_pool, pool_options, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
