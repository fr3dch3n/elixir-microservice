defmodule ElixirMicroservice.KafkaStream do
  require Logger
  #use GenServer

  def start_link() do
        IO.puts "--> starting the kafka-stream"
        #GenServer.start_link(__MODULE__, [])
        KafkaEx.stream("test", 0) |> Enum.map(fn x -> IO.puts x end) 



  end

end
