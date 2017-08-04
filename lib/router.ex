defmodule MagellanMicroservice.Router do
  @moduledoc """
  This module is used by the server to provide the default routes to status and health page.
  Via the `register_router/0` function, one can add a custom router to expand the functionality.
  """

  alias MagellanMicroservice.AppStatus
  require EEx
  require Logger

  use Plug.Router
  plug MagellanMicroservice.PrometheusExporter     # makes the /metrics URL happen
  plug MagellanMicroservice.PipelineInstrumenter
  plug :match
  plug :dispatch

  @doc """
   Ths function gets invoked by `MagellanMicroservice.AppStatus.get_status/0` and MagellanMicroservice.AppStatus.get_health/0.
   It returns the current status of the module.
   """
   @spec status() :: %{atom => atom}
  def status() do
    %{status: :ok}
  end

  @doc """
  This function gets invoked by the start_link function.
  It registers its status function `status/0` and starts an Agent `:router` which can store a custom router.
  """
  @spec init([]) :: any()
  def init([]) do
    Logger.info("--> starting the magellan-router")
    AppStatus.register_status_fun(:router, &status/0)
    Agent.start_link(fn ->
    %{}
   end, name: :router)
    Logger.info("--> started the magellan-router")
   {:ok, self()}
  end

  @doc """
  This funtion enables you to register your own router.
  All requests that don't match the configured status and health url will be send to the specified router.
  Refer to the examples in the Readme in order to use your own router with this microservice.
  """
  @spec register_router(any) :: atom()
  def register_router(x) do
    Agent.update(:router, fn(_n) -> %{status: :ok,
    router: x} end)
    :ok
  end

  @spec get_router() :: any()
  defp get_router() do
    Agent.get(:router, fn(n) ->
      n #validate and stuff, else :error
    end)
  end

  get Application.fetch_env!(:magellan_microservice, :health) do
    send_resp(conn, 200, AppStatus.get_health)
  end

  get Application.fetch_env!(:magellan_microservice, :status) do
    send_resp(conn, 200, AppStatus.get_status_json)
  end

  match _ do
    n = get_router() # onle one router atm
    if Map.get(n, :status) == :ok do
      Map.get(n, :router).call(conn, [])
    else
      Logger.warn "No custom router defined!"
      send_resp(conn, 404, "Invalide URL.")
    end
  end
end
