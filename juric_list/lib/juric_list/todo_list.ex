defmodule JuricList.TodoList do

  alias JuricList.{MapOfLists}

  def new() do
    %{}
  end

  def add_entry(todo_list, date, entry) do
    MapOfLists.update(todo_list, date, entry)
  end

  def entries(todo_list, date) do
    MapOfLists.get_list(todo_list, date)
  end
end
