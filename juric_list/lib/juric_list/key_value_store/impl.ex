defmodule JuricList.KeyValueStore.Impl do

  def new() do
    %{}
  end

  def put(map, key, value) do
    Map.put(map, key, value)
  end

  def get(map, key) do
    Map.get(map, key)
  end
end
