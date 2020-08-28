defmodule Pre8Restart.Database.FileSystemDb.State do
  alias Pre8Restart.Database.FileSystemDb.{Worker}

  def new() do
    %{worker1: Worker.new()}
  end

  def store(state, key, value) do
    Worker.store(state.worker1, key, value)
    state
  end

  def get(state, key) do
    Worker.get(state.worker1, key)
  end

  def clear(state) do
    Worker.clear(state.worker1)
  end
end

# TODO next Easy now just make 3 workers, and use book trick to "random" pick one
