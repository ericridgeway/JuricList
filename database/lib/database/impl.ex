defmodule Database.Impl do

  alias Database.{Worker}

  def new() do
    worker_pid_map =
      Enum.reduce(0..2, %{}, fn (id, map) ->
        {:ok, worker_pid} = Worker.start()

        Map.put(map, id, worker_pid)
      end)

    %{worker1: worker_pid_map[0], workers: worker_pid_map}
    |> IO.inspect(label: "")
  end

  def store(state, key, data) do
    # %{worker1: worker_pid} = state

    # :ok = Worker.store(worker_pid, key, data)

    # state
    :ok = Worker.store(state.worker1, key, data)

    state
  end

  def delete(state, key) do
    :ok = Worker.delete(state.worker1, key)

    state
  end

  def get(state, key) do
    Worker.get(state.worker1, key)
  end
end
