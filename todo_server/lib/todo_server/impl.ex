defmodule TodoServer.Impl do

  def new() do
    TodoList.new()
  end

  def add_entry(state, entry) do
    TodoList.add_entry(state, entry)
  end

  def update_entry(state, id, updater_fun) do
    TodoList.update_entry(state, id, updater_fun)
  end

  def delete_entry(state, id) do
    TodoList.delete_entry(state, id)
  end

  def entries(state, date) do
    TodoList.entries(state, date)
  end
end
