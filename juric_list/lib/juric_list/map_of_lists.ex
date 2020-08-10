defmodule JuricList.MapOfLists do

  def update(map, key, list_addition) do
    Map.update(map, key, [list_addition], &([list_addition | &1]))
  end

  def get_list(map, key) do
    map
    |> Map.get(key, [])
    |> Enum.reverse()
  end
end
