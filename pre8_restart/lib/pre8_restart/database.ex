defmodule Pre8Restart.Database do
  @type key :: any
  @type value :: any

  @callback start() :: :ok
  @callback store(key, value) :: :ok
  @callback get(key) :: value
end
