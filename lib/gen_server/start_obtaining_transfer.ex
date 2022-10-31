defmodule GenServer.StartObtainingTransfer do
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

  def get_info_pid(pid), do: Process.info(pid)

  defp schedule_work() do
    GenServer.cast(self(), :start_process)
  end
end
