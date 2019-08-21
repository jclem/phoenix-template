defmodule App.Repo do
  use Ecto.Repo,
    otp_app: :app,
    adapter: Ecto.Adapters.Postgres

  @impl true
  def init(_context, config) do
    if Mix.env() == :prod do
      database_url = System.fetch_env!("DATABASE_URL")
      pool_size = String.to_integer(System.fetch_env!("DATABASE_POOL_SIZE"))

      {:ok,
       config
       |> Keyword.put(:url, database_url)
       |> Keyword.put(:pool_size, pool_size)}
    else
      {:ok, config}
    end
  end
end
