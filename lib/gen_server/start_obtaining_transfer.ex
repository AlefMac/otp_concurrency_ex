defmodule GenServer.StartObtainingTransfer do
  @moduledoc """
  module responsible for initializing the application and calling the function responsible for updating transfers
  """
  use GenServer, restart: :transient

  alias Main.TransferGetAndUpdate

  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_cast(:start_process, state) do
    TransferGetAndUpdate.run()
    {:noreply, state}
  end

  @doc """
  Function responsible for getting the status of the process in current
  """
  def get_info_pid(pid), do: Process.info(pid)

  @doc """
  Function responsible for forcefully complete the process
  """
  def break_application_force(pid), do: Process.exit(pid, :kill)

  def schedule_work() do
    GenServer.cast(self(), :start_process)
  end
end
