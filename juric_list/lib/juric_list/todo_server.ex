defmodule JuricList.TodoServer do

  alias JuricList.{TodoList, ServerProcess}

  def start() do
    ServerProcess.start(__MODULE__)
  end

  def add_entry(pid, entry) do
    ServerProcess.cast(pid, {:add_entry, entry})
  end

  def update_entry(pid, id, updater_fun) do
    ServerProcess.cast(pid, {:update_entry, id, updater_fun})
  end

  def delete_entry(pid, id) do
    ServerProcess.cast(pid, {:delete_entry, id})
  end

  def entries(pid, date) do
    ServerProcess.call(pid, {:entries, date})
  end


  def init() do
    TodoList.new()
  end

  def handle_cast({:add_entry, entry}, todo_list) do
    TodoList.add_entry(todo_list, entry)
  end

  def handle_cast({:update_entry, id, updater_fun}, todo_list) do
    TodoList.update_entry(todo_list, id, updater_fun)
  end

  def handle_cast({:delete_entry, id}, todo_list) do
    TodoList.delete_entry(todo_list, id)
  end

  def handle_call({:entries, date}, todo_list) do
    {TodoList.entries(todo_list, date), todo_list}
  end


  defp process_message(_todo_list, :finish) do
    :finish
  end
end
