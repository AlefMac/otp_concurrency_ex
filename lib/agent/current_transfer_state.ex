defmodule Agent.CurrentTransferState do
  use Agent

  require Logger

  def start_link(initial_value, module) do
    {:ok, pid} = Agent.start_link(fn -> initial_value end, name: module)
    Logger.info("[#{__MODULE__}] - Processo salvo com sucesso - PID: #{inspect(pid)} ")
  end

  def get_all(module) do
    Agent.get(module, & &1)
  end

  def get_value_by(step, module) do
    Agent.get(module, fn list ->
      Enum.map(list, fn transfer ->
        if transfer.etapa == step || transfer.status == step || transfer.valor == step,
          do: transfer
      end)
      |> Enum.reject(&is_nil/1)
    end)
  end
end
