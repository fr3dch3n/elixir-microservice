defmodule MagellanMicroservice.AppStatus.Test do
  use ExUnit.Case, async: false
  alias MagellanMicroservice.AppStatus



  test "check for clean status" do
    Agent.update(AppStatus, fn(_n) -> %{} end)
    assert AppStatus.get_status == %{status: :ok, statusDetails: %{}}
    assert AppStatus.get_health == "OK"
  end
  test "add a simple status function" do
    Agent.update(AppStatus, fn(_n) -> %{} end)
    assert AppStatus.register_status_fun(:test,  fn() -> %{status: :ok, info: "processed 0 messagges"} end) == :ok
    assert AppStatus.get_status == %{status: :ok, statusDetails: %{test: %{status: :ok, info: "processed 0 messagges"}}}
    assert AppStatus.get_health == "OK"
  end
end
