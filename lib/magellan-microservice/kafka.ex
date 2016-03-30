defmodule ElixirMicroservice.Kafka do
  alias ElixirMicroservice.KafkaStream
  use Supervisor

  def start_link() do
    IO.puts "--> starting the kafka-supervisor"
    Supervisor.start_link(__MODULE__, [])

  end

  def init([]) do

        children = [
          supervisor(KafkaStream, [])
        ]

        supervise(children, strategy: :one_for_one)
  end
end
