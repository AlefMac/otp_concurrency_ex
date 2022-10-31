defmodule Main.TransferGetAndUpdate do
  require Logger

  alias GenServer.StartObtainingTransfer
  alias OtpConcurrencyEx.Transfers
  alias Agent.CurrentTransferState

  def run() do
    Logger.info("[#{__MODULE__}] - Começando a atualizar as transferências.")

    transfer = Transfers.get_transfer_not_completed()

    save_state_in_memory(transfer)
  end

  def get_transfer_get_by(step),
    do: CurrentTransferState.get_value_by(step, __MODULE__)

  def get_status_process(pid \\ self()), do: StartObtainingTransfer.get_info_pid(pid)

  defp save_state_in_memory(list_transfer) do
    list_transfer
    |> build_struct_map_transfer()
    |> Enum.reject(&is_nil/1)
    |> CurrentTransferState.start_link(__MODULE__)
  end

  defp build_struct_map_transfer(list_transfer) do
    Enum.map(list_transfer, fn transfer ->
      transfer = Map.from_struct(transfer)
      %{etapa: transfer.etapa, status: transfer.status, valor: transfer.valor}
    end)
  end
end
