defmodule Pre8Restart.DatabaseDef do
  @type key :: any
  @type value :: any

  @callback start() :: :ok
  @callback get(key) :: value
  @callback store(key, value) :: :ok
end

# TODO rename this to Database, and cur Database -> FilesystemDb
