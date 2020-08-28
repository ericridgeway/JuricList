defmodule Pre8Restart.TodoList do

  alias Pre8Restart.Database.{NothingDb}

  @type t :: pid

  import Pre8Restart.TodoList.Types
  get_shared()

  # TODO doc the database type?

  @spec new(name, database) :: t
  def new(name, database \\ NothingDb) do
    {:ok, pid} = GenServer.start(__MODULE__.Server, {name, database})
    pid
  end

  @spec add_entry(t, entry) :: t
  def add_entry(pid, entry) do
    :ok = GenServer.call(pid, {:add_entry, entry})
    pid
  end

  @spec update_entry(t, id, fun) :: t
  def update_entry(pid, id, updater_fun) do
    :ok = GenServer.call(pid, {:update_entry, id, updater_fun})
    pid
  end

  @spec update_entry(t, entry) :: t
  def update_entry(pid, updated_entry) do
    :ok = GenServer.call(pid, {:update_entry, updated_entry})
    pid
  end

  @spec delete_entry(t, id) :: t
  def delete_entry(pid, id) do
    :ok = GenServer.call(pid, {:delete_entry, id})
    pid
  end


  @spec titles(t, date) :: [title]
  def titles(pid, target_date) do
    GenServer.call(pid, {:titles, target_date})
  end

  @spec entries(t, date) :: [entry]
  def entries(pid, target_date) do
    GenServer.call(pid, {:entries, target_date})
  end

  @spec name(t) :: name
  def name(pid) do
    GenServer.call(pid, {:name})
  end
end
