defmodule Main.TransferGetAndUpdate do
  @moduledoc"""
  Module responsible for having the business rules and processing of transfers
  """
  require Logger

  alias GenServer.StartObtainingTransfer
  alias OtpConcurrencyEx.Transfers
  alias Agent.CurrentTransferState

  @doc"""
  Function that is called there in the GenServer module
  """
  def run() do
    Logger.info("[#{__MODULE__}] - Começando a atualizar as transferências.")

    transfer = Transfers.get_transfer_not_completed()

    save_state_in_memory(transfer)

    ## other logics to be implemented ...
  end

  @doc"""
  Function responsible for get the transfers that are saved in memory
  """
  def get_transfer_in_memory_by(param),
    do: CurrentTransferState.get_value_by(param, __MODULE__)
  
  @doc"""
  Function responsible for getting the status of the process in current this module
  """
  def get_status_process(), 
    do: StartObtainingTransfer.get_info_pid(self())

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
