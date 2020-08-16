defmodule TodoServer.Impl do

  @enforce_keys [:name, :todo_list]
  defstruct @enforce_keys

  alias __MODULE__

  def new(name) do
    %Impl{
      name: name,
      todo_list: TodoList.new(),
    }
  end

  def add_entry(state, entry) do
    # %{state | todo_list: TodoList.add_entry(state.todo_list, entry)}

    update_in(state.todo_list, &TodoList.add_entry(&1, entry))
  end

  def update_entry(state, id, updater_fun) do
    update_in(state.todo_list, &TodoList.update_entry(&1, id, updater_fun))
  end

  def delete_entry(state, id) do
    update_in(state.todo_list, &TodoList.delete_entry(&1, id))
  end

  def entries(state, date) do
    TodoList.entries(state.todo_list, date)
  end
end
