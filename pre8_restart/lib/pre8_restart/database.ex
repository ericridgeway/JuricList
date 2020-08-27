defmodule Pre8Restart.Database do
  @type t :: :ok
  @type key :: any
  @type value :: any

  @db_folder "./persist"

  @spec new() :: t
  # defdelegate new(), to: Map
  def new() do
    File.mkdir_p!(@db_folder)

    :ok
  end

  @spec store(t, key, value) :: t
  # defdelegate store(state, key, value), to: Map, as: :put
  def store(_state, key, value) do
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(value))

    :ok
  end

  @spec get(t, key) :: value
  # defdelegate get(state, key), to: Map
  def get(_state, key) do
    case File.read(file_name(key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
  end


  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
