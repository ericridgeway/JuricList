defmodule Pre8Restart.Database do
  @type t :: %{}
  @type key :: any
  @type value :: any

  @spec new() :: t
  defdelegate new(), to: Map
  # def new() do
  #   -1
  # end

  @spec store(t, key, value) :: t
  defdelegate store(state, key, value), to: Map, as: :put
  # def store(state, key, value) do
  #   -1
  # end

  @spec get(t, key) :: value
  defdelegate get(state, key), to: Map
end
