defmodule OtpConcurrencyEx do
  use GenServer

  alias Main.TransferGetAndUpdate

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    TransferGetAndUpdate.run()
    # Reschedule once more
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 10000)
  end
end
