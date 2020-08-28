defmodule Pre8Restart.DatabaseDef do
  @type key :: any
  @type value :: any

  @callback start() :: :ok
  @callback store(key, value) :: :ok
  @callback get(key) :: value
end

# TODO rename this to Database, and cur Database -> FilesystemDb
