defmodule Cache do
  @moduledoc """
  Run multiple TodoServer's at once, each saved under a Name
  """

  @me __MODULE__

  def start_link() do
    GenServer.start_link(__MODULE__.Server, nil, name: @me)
  end

  @doc """
  Get server process PID for given 'todo_list_name'

  Creates new server_process if one doesn't exist yet for that
  name
  """
  def server_process(todo_list_name) do
    GenServer.call(@me, {:server_process, todo_list_name})
  end
end
