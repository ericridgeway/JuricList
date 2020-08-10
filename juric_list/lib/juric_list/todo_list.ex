defmodule JuricList.TodoList do

  def new() do
    %{}
  end

  def add_entry(todo_list, date, entry) do
    Map.update(todo_list, date, [entry], &([entry | &1]))
  end

  def entries(todo_list, date) do
    todo_list
    |> Map.get(date)
    |> Enum.reverse()
  end
end
