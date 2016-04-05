defmodule MagellanMicroservice.NewRouter do
  use Plug.Router
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
