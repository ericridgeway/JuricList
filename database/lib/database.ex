defmodule Database do
  alias Database.{Worker}

  defdelegate start(), to: Worker
  defdelegate store(key, data), to: Worker
  defdelegate delete(key), to: Worker
  defdelegate get(key), to: Worker
end
