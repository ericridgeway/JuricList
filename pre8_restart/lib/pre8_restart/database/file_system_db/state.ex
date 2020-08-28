defmodule Pre8Restart.Database.FileSystemDb.State do
  alias Pre8Restart.Database.FileSystemDb.{Worker}

  def new() do
    Worker.new()
  end

  def store(_state, key, value) do
    Worker.store(nil, key, value)
  end

  def get(_state, key) do
    Worker.get(nil, key)
  end

  def clear(_state) do
    Worker.clear(nil)
  end
end
