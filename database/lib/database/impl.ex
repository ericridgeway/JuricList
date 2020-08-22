defmodule Database.Impl do

  @num_workers 3

  alias Database.{Worker}

  def new() do
    worker_range = 0..@num_workers-1

    worker_pid_map =
      Enum.reduce(worker_range, %{}, fn (id, map) ->
        {:ok, worker_pid} = Worker.start()

        Map.put(map, id, worker_pid)
      end)

    %{workers: worker_pid_map}
  end

  # TODO maybe some of these lines like worker <- get moved up to Server lvl, decide after I do the impl -> state thing
  def store(state, key, data) do
    worker = choose_worker(state.workers, key)

    :ok = Worker.store(worker, key, data)

    state
  end

  def delete(state, key) do
    worker = choose_worker(state.workers, key)

    :ok = Worker.delete(worker, key)

    state
  end

  def get(state, key) do
    worker = choose_worker(state.workers, key)

    Worker.get(worker, key)
  end


  defp choose_worker(workers, key) do
    Map.get(workers, :erlang.phash2(key, @num_workers))
  end
end
