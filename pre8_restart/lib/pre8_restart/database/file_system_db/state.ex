defmodule Pre8Restart.Database.FileSystemDb.State do
  alias Pre8Restart.Database.FileSystemDb.{Worker}
  alias Pre8Restart.Database, as: D

  @num_workers 3

  @type t :: %{worker_num => worker_pid}
  @type worker_num :: pos_integer
  @type worker_pid :: pid

  @spec new() :: t
  def new() do
    Enum.reduce(0..@num_workers-1, %{}, fn key, worker_map ->
      Map.put(worker_map, key, Worker.new())
    end)
  end

  @spec store(t, D.key, D.value) :: t
  def store(state, key, value) do
    Worker.store(state[1], key, value)
    state
  end

  @spec get(t, D.key) :: D.value
  def get(state, key) do
    Worker.get(state[1], key)
  end

  @spec clear(t) :: :ok
  def clear(state) do
    Worker.clear(state[1])
  end
end

# TODO next Easy now just make 3 workers, and use book trick to "random" pick one
