defmodule App.Context do
  @moduledoc """
  Shared helpers for application context modules

      defmodule App.Identity do
        use App.Context
      end
  """

  defmacro __using__(_opts) do
    quote do
      import Ecto
      import Ecto.Changeset

      alias App.Repo
      alias Ecto.Changeset
    end
  end
end
