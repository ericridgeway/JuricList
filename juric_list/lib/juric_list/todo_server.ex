defmodule JuricList.TodoServer do

  alias JuricList.{TodoList}

  @me :whatever

  def start() do
    spawn(fn ->
      Process.register(self(), @me)

      loop(TodoList.new())
    end)
  end

  def add_entry(entry) do
    send(@me, {:add_entry, entry})
  end

  def update_entry(todo_server, id, updater_fun) do
    send(todo_server, {:update_entry, id, updater_fun})
  end

  def delete_entry(todo_server, id) do
    send(todo_server, {:delete_entry, id})
  end

  def entries(date) do
    send(@me, {:entries, self(), date})

    receive do
      {:entries_reply, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end


  defp loop(todo_list) do
    todo_list =
      receive do
        message -> process_message(todo_list, message)
      end

    loop(todo_list)
  end

  defp process_message(todo_list, {:add_entry, entry}) do
    TodoList.add_entry(todo_list, entry)
  end

  defp process_message(todo_list, {:update_entry, id, updater_fun}) do
    TodoList.update_entry(todo_list, id, updater_fun)
  end

  defp process_message(todo_list, {:delete_entry, id}) do
    TodoList.delete_entry(todo_list, id)
  end

  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:entries_reply, TodoList.entries(todo_list, date)})

    todo_list
  end
end
