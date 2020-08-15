defmodule Cache.Impl do

  defdelegate new(), to: Map
  defdelegate fetch(map, key), to: Map
  defdelegate put(map, key, value), to: Map
  # def new() do
  #   %{}
  # end

  # def fetch
end

