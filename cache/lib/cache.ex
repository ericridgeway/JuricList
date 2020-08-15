defmodule Cache do
  @moduledoc """
  Run multiple TodoServer's at once, each saved under a Name
  """

  def start() do
    GenServer.start(__MODULE__.Server, nil)
  end

  @doc """
  Get server process PID for given 'todo_list_name'

  Creates new server_process if one doesn't exist yet for that
  name
  """
  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end
end
