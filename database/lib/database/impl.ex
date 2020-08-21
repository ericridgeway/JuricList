defmodule Database.Impl do

  alias Database.{Worker}

  def new() do
    {:ok, worker_pid} = Worker.start()

    %{worker1: worker_pid}
  end

  def store(state, key, data) do
    # %{worker1: worker_pid} = state

    # :ok = Worker.store(worker_pid, key, data)

    # state
    :ok = Worker.store(state.worker1, key, data)

    state
  end

  def get(state, key) do
    Worker.get(state.worker1, key)
  end
end
