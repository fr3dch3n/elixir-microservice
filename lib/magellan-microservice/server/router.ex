defmodule ElixirMicroservice.Server.Router do
  alias ElixirMicroservice.AppStatus
  alias ElixirMicroservice.Server.RouterHelper
  alias ElixirMicroservice.RedixPool
  require EEx

  def init(default_opts) do
    IO.puts "--> starting the router"
    default_opts
  end
  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  defmodule RedisRouter do
    use RouterHelper
    EEx.function_from_file :defp, :template_add, "templates/redis/add.eex", [:user_id]
    EEx.function_from_file :defp, :template_all, "templates/redis/all.eex", [:content]
    EEx.function_from_file :defp, :template_show_user, "templates/redis/show_user.eex", [:user_id, :content]

    def route("GET", ["redis", "add", user_id], conn) do
      RedixPool.command(~w(INCR #{user_id}))
      page_contents = template_add(user_id)
      conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
    end

    def route("GET", ["redis", "all"], conn) do
      {_, content} = RedixPool.command(~w(KEYS *))
      page_contents = template_all(content)
      Enum.map(content, fn x -> IO.puts x end)
      conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
    end

    def route("GET", ["redis", user_id], conn) do
      {_, content} = RedixPool.command(~w(GET #{user_id}))
      page_contents = template_show_user(user_id, content)
      conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
    end

    def route(_method, _path, conn) do
      conn |> Plug.Conn.send_resp(404, "Couldn't find that user page, sorry!")
    end
  end


  @user_router_options RedisRouter.init([])
  def route("GET", ["redis" | _], conn) do
   RedisRouter.call(conn, @user_router_options)
 end
 def route("GET", ["status"], conn) do
    conn |> Plug.Conn.send_resp(200, AppStatus.getJsonState)
 end

 def route(_method, _path, conn) do
   conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
 end

end
