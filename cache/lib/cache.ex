defmodule Cache do
  # defdelegate start(), to: Cache.Impl
  # defdelegate server_process(server_pid, something), to: Cache.Impl

  def start() do
    GenServer.start(__MODULE__.Server, nil)
  end

  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end
end
