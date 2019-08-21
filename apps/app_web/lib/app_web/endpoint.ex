defmodule AppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :app_web

  socket "/socket", AppWeb.UserSocket,
    websocket: [timeout: 45_000],
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :app_web,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_app_web_key",
    signing_salt: "d957HQfI"

  plug AppWeb.Router

  @impl true
  def init(:supervisor, config) do
    if Mix.env() == :prod do
      host = System.fetch_env!("HOST")
      port = String.to_integer(System.fetch_env!("PORT"))
      secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
      redis_node_name = host <> "-" <> Base.encode16(:crypto.strong_rand_bytes(16), case: :lower)
      redis_url = System.fetch_env!("REDIS_URL")

      {:ok,
       config
       |> put_in([:url, :host], host)
       |> put_in([:http, :port], port)
       |> put_in([:pubsub, :node_name], redis_node_name)
       |> put_in([:pubsub, :url], redis_url)
       |> Keyword.put(:secret_key_base, secret_key_base)}
    else
      {:ok, config}
    end
  end
end
