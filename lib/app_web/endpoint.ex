defmodule AppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :app

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_app_key",
    signing_salt: "ZWj5hrrE"
  ]

  socket "/socket", AppWeb.UserSocket,
    websocket: [timeout: 45_000],
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [timeout: 45_000, connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :app,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :app
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug AppWeb.Router

  @impl true
  def init(:supervisor, config) do
    if Mix.env() == :prod do
      host = get_host!()
      port = System.fetch_env!("PORT")
      secret_key_base = System.fetch_env!("SECRET_KEY_BASE")

      {:ok,
       config
       |> put_in([:url, :host], host)
       |> put_in([:http, :port], port)
       |> Keyword.put(:secret_key_base, secret_key_base)}
    else
      {:ok, config}
    end
  end

  defp get_host! do
    cond do
      host = System.get_env("HOST") ->
        host

      app_name = System.get_env("HEROKU_APP_NAME") ->
        "#{app_name}.herokuapp.com"

      true ->
        raise "Missing HOST or HEROKU_APP_NAME"
    end
  end
end
