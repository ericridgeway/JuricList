defmodule Pre8Restart.Database.NothingDb do
  alias Pre8Restart.{Database}

  @behaviour Database

  @impl Database
  def start(), do: :ok

  @impl Database
  def store(_key, _value), do: :ok

  @impl Database
  def get(_key), do: nil
end

# ASK @William I wish I could combine this as "defaults" in database.ex
# TODO actually I bet I can combine this with database.ex, maybe with @optional_callback or something
