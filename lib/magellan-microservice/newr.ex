defmodule ElixirMicroservice.NewRouter do
  use Plug.Router
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.RouterHelper
  require EEx

  plug :match
  plug :dispatch


get "/hello" do
  send_resp(conn, 200, "Antwort aus meiner App.")
end


  match _ do
    send_resp(conn, 404, "Invalide URL.")
  end



end
