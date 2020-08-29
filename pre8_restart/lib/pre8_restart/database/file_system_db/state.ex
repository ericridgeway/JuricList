defmodule Pre8Restart.Database.FileSystemDb.State do
  alias Pre8Restart.Database.FileSystemDb.{Worker}
  alias Pre8Restart.Database, as: D

  @num_workers 3

  @type t :: %{worker_num => worker_pid}
  @type worker_num :: pos_integer
  @type worker_pid :: pid

  @spec new() :: t
  def new() do
    Enum.reduce(0..@num_workers-1, %{}, fn worker_num, worker_map ->
      Map.put(worker_map, worker_num, Worker.new())
    end)
  end

  @spec store(t, D.key, D.value) :: t
  def store(state, key, value) do
    choose_worker(state, key)
    |> Worker.store(key, value)

    state
  end

  @spec get(t, D.key) :: D.value
  def get(state, key) do
    choose_worker(state, key)
    |> Worker.get(key)
  end

  # NOTE I'm not positive this needed. FileSystemDb.Server (the thing that calls this) is already shutting down this daddy proccess. That might automatically kill the workers we started up in init/new above. For now I'll have this manually go through and kill them, maybe take it out when we get to the supervisor and link stuff
  @spec clear(t) :: :ok
  def clear(state) do
    Enum.map(state, fn {_worker_num, worker_pid} ->
      Worker.clear(worker_pid)
    end)

    :ok
  end


  defp choose_worker(state, key) do
    worker_num = :erlang.phash2(key, @num_workers)

    Map.get(state, worker_num)
  end
end

# TODO next Easy now just make 3 workers, and use book trick to "random" pick one
