defmodule MagellanMicroservice.PipelineInstrumenter.Test do
  use ExUnit.Case, async: true
  alias MagellanMicroservice.Router
  use Plug.Test

  @opts MagellanMicroservice.Router.init([])
  test "metrics contains the successful request to health" do
    Router.call(conn(:get, "/test/health"), @opts)
    conn = Router.call(conn(:get, "/metrics"), @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert String.contains?(conn.resp_body, "http_requests_total{status_class=\"success\",method=\"GET\",host=\"www.example.com\",scheme=\"http\",request_path=\"/test/health\"}") == :true
  end
end