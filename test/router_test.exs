defmodule MagellanMicroservice.Router.Test do
  use ExUnit.Case, async: true
  alias MagellanMicroservice.Router
  use Plug.Test

  @opts MagellanMicroservice.Router.init([])
  test "returns the health code" do
    conn = Router.call(conn(:get, "/health"), @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end

  test "return the status page" do
    conn = Router.call(conn(:get, "/status"), @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"statusDetails\":{\"server\":{\"status\":\"ok\"},\"router\":{\"status\":\"ok\"}},\"status\":\"ok\"}"
  end

  test "no matching route should return 404" do
    conn = Router.call(conn(:get, "/foobar"), @opts)
    assert conn.state == :sent
    assert conn.status == 404
  end

end
