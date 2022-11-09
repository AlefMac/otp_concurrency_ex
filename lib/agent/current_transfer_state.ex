defmodule Agent.CurrentTransferState do
  @moduledoc """
  Module responsible for temporarily saving data for some processing
  """
  use Agent

  require Logger

  def start_link(initial_value, module) do
    {:ok, pid} = Agent.start_link(fn -> initial_value end, name: module)
    Logger.info("[#{__MODULE__}] - Processo salvo com sucesso - PID: #{inspect(pid)} ")
  end

  @doc """
  Get all transfers in memory
  """
  def get_all(module) do
    Agent.get(module, & &1)
  end

  @doc """
  Delete transfer at index 0
  """
  def delete_transfer(module) do
    Agent.update(module, fn list ->
      List.delete_at(list, 0)
    end)
  end

  @doc """
  Gets the values according to the received parameter
  """
  def get_value_by(param, module) do
    Agent.get(module, fn list ->
      Enum.map(list, fn transfer ->
        if transfer.etapa == param || transfer.status == param || transfer.valor == param,
          do: transfer
      end)
      |> Enum.reject(&is_nil/1)
    end)
  end
end
