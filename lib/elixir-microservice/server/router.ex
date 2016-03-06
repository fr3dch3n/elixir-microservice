defmodule ElixirMicroservice.Server.Router do
  alias ElixirMicroservice.AppStatus, as: AppStatus
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch


  @userid   "uid"
  @password "pwd"

  get "/" do
    conn = fetch_query_params(conn, []) # populates conn.params
    %{ @userid => usr, @password => pass } = conn.params
    send_resp(conn, 200, "Hello #{usr}. Your password is #{pass}")
  end

  get "/hello" do
    send_resp(conn, 200, "wooifjeoorld")
  end

  get "/status" do
    send_resp(conn, 200, AppStatus.getJsonState())
  end

  #forward "/users", to: UsersRouter

  match _ do
    send_resp(conn, 404, "oops")
  end
end
