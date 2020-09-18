defmodule App.Schema do
  @moduledoc """
  Provides common setup for application schemata.

      defmodule App.User do
        use App.Schema

        schema "users" do
        end
      end
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      @type t :: %__MODULE__{}
    end
  end
end
