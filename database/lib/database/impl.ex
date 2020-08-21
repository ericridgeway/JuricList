defmodule Database.Impl do

  alias Database.{Worker}

  def new() do
    {:ok, worker_pid} = Worker.start()
    [worker_pid]
  end
end
