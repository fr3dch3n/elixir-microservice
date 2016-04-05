defmodule MagellanMicroservice.AppStatus do
  require Logger

  def start_link() do
    Logger.info "--> starting the magellan-app-status"
    conf = Application.get_all_env :microservice
    Agent.start_link(fn ->
    %{}
   end, name: __MODULE__)
  end

  def registerStatusFun(appName, fun) do
    Agent.update(__MODULE__, fn(n) -> Map.put(n, appName, fun) end)
  end

  def getStatus() do
    Agent.get(__MODULE__, fn(n) ->
      %{
        status: :ok,
        statusDetails: Enum.reduce(n, %{},  fn({name, fun}, acc) -> Map.put(acc, name, fun.()) end)
      }
    end)
  end

  def getJsonState() do
    Poison.Encoder.encode(getStatus, [])
  end

  def getHealth() do
    "OK"
  end
end
