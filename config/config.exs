# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :app,
  ecto_repos: [App.Repo]

config :app_web,
  ecto_repos: [App.Repo],
  generators: [context_app: :app, binary_id: true]

# Configures the endpoint
config :app_web, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9tH61F08cW/0DXgcBZCZEGf4IgJ9y1pPvbzHWfBC5DCAe9s6g3pPNFo9fRBrnQxj",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AppWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "dlUfbakdmkx+vyBW9ogUHck2h7TXfwpnHacKXy2rXm7N/pNzOmeOA3ZG/aSxpPcW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
