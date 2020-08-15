defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate fetch(map, key), to: Map
  defdelegate put(map, key, value), to: Map
end

