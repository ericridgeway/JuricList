defmodule Pre8Restart.TodoList.Server do
  use GenServer

  alias Pre8Restart.TodoList.{State}

  @impl GenServer
  def init(name) do
    {:ok, State.new(name)}
  end

  @impl GenServer
  def handle_call({:add_entry, entry}, _from, state) do
    state
    |> State.add_entry(entry)
    |> reply(:ok)
  end

  @impl GenServer
  def handle_call({:update_entry, id, updater_fun}, _from, state) do
    state
    |> State.update_entry(id, updater_fun)
    |> reply(:ok)
  end

  @impl GenServer
  def handle_call({:update_entry, updated_entry}, _from, state) do
    state
    |> State.update_entry(updated_entry)
    |> reply(:ok)
  end

  @impl GenServer
  def handle_call({:delete_entry, id}, _from, state) do
    state
    |> State.delete_entry(id)
    |> reply(:ok)
  end


  @impl GenServer
  def handle_call({:titles, target_date}, _from, state) do
    state
    |> reply(State.titles(state, target_date))
  end

  @impl GenServer
  def handle_call({:entries, target_date}, _from, state) do
    state
    |> reply(State.entries(state, target_date))
  end

  @impl GenServer
  def handle_call({:name}, _from, state) do
    state
    |> reply(State.name(state))
  end


  defp reply(state, msg) do
    {:reply, msg, state}
  end
end
