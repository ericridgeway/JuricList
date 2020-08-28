defmodule Pre8Restart.NothingDb do
  alias Pre8Restart.{DatabaseDef}

  @behaviour DatabaseDef

  @impl DatabaseDef
  def start(), do: :ok

  @impl DatabaseDef
  def store(_key, _value), do: :ok

  @impl DatabaseDef
  def get(_key), do: nil
end
