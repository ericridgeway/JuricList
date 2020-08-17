defmodule TodoServer.Impl do

  @enforce_keys [:name, :todo_list]
  defstruct @enforce_keys

  alias __MODULE__

  def new(name) do
    todo_list =
      Database.get(name) || TodoList.new()

    %Impl{
      name: name,
      todo_list: todo_list,
    }
  end

  def add_entry(state, entry) do
    update_in(state.todo_list, &TodoList.add_entry(&1, entry))
    |> db_save()
  end

  def update_entry(state, id, updater_fun) do
    update_in(state.todo_list, &TodoList.update_entry(&1, id, updater_fun))
    |> db_save()
  end

  def delete_entry(state, id) do
    update_in(state.todo_list, &TodoList.delete_entry(&1, id))
    |> db_save()
  end


  def entries(state, date) do
    TodoList.entries(state.todo_list, date)
  end

  def name(state) do
    state.name
  end


  defp db_save(state) do
    :ok = Database.store(state.name, state.todo_list)

    state
  end
end

# TODO @grp is there a way to "new abstraction layer" pull out the db stuff from here. It's clearly seperate from the other logic. But I need one to always happen when the other does. It would be nice to get rid of all the |> db_save() 's and the db retrieve-if-exists steps
#
# So, question summary:
# 1- Proper way to test when there's external save/restore db stuff happening, wether file saves or ecto or whatever else. So test 2 doesn't try to run something that goes "hey, I should restore data that existed" even tho that's test 1's data and we don't want it to be restored
#
# 2- New module/abstraction layer for these 2 jobs combined, how do I seperate (above note)
