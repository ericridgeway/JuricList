defmodule Database.Server do
  use GenServer

  alias Database.{Impl}

  @impl GenServer
  def init(_init_arg) do
    {:ok, Impl.new()}
  end
end
