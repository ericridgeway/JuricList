defmodule Database.Impl do

  alias Database.{Worker}

  def new() do
    {:ok, worker_pid} = Worker.start()
    %{worker1: worker_pid}
  end

  def store(state, key, data) do
    %{worker1: worker_pid} = state

    reply = Worker.store(worker_pid, key, data)

    {reply, state}
  end
end
