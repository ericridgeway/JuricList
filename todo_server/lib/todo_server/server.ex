defmodule TodoServer.Server do
  use GenServer

  def init(_init_arg) do
    {:ok, TodoList.new()}
  end

  def handle_cast({:add_entry, entry}, todo_list) do
    {:noreply, TodoList.add_entry(todo_list, entry)}
  end

  def handle_cast({:update_entry, id, updater_fun}, todo_list) do
    {:noreply, TodoList.update_entry(todo_list, id, updater_fun)}
  end

  def handle_cast({:delete_entry, id}, todo_list) do
    {:noreply, TodoList.delete_entry(todo_list, id)}
  end

  def handle_call({:entries, date}, _sender, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
end

