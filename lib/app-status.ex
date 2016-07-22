defmodule MagellanMicroservice.AppStatus do
  @moduledoc """
  This module handles the overall app-status.
  One can register a function which gets invoked when getStatus/0 is called to build the app-status.
  """

  require Logger

  @doc """
  The App-Status consists of an Agent which stores the registered status function.
  Refer to Agent.start_link documentation.
  """
  @spec start_link :: any()
  def start_link() do
    Logger.info "--> starting the magellan-app-status"
    Agent.start_link(fn ->
    %{}
   end, name: __MODULE__)
  end

  @doc """
  Use this function to store a function under a name. The function will be invoked when the app-status or health are requested.
  Return `:ok`.
  """
  @spec register_status_fun(atom,   any) :: atom()
  def register_status_fun(appName, fun) do
    Agent.update(__MODULE__, fn(n) -> Map.put(n, appName, fun) end)
    :ok
  end

  @doc """
  Retrieve all results of the stored status functions.
  """
  @spec get_status :: map()
  def get_status() do
    Agent.get(__MODULE__, fn(n) ->
      %{
        status: :ok,
        statusDetails: Enum.reduce(n, %{},  fn({name, fun}, acc) -> Map.put(acc, name, fun.()) end)
      }
    end)
  end

  @doc """
  This function returns the App-Status.get_status result endcoded in json.
  """
  @spec get_status_json :: term()
  def get_status_json() do
    Poison.Encoder.encode(get_status(), [])
  end

  @doc """
  Returns a simple status represented by OK or ERROR.
  """
  @spec get_health :: binary
  def get_health() do
    "OK"
  end
end
