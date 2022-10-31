defmodule Models.Seeds.TransferSeed do
  @moduledoc false

  require Logger

  alias OtpConcurrencyEx.Transfers
  alias OtpConcurrencyEx.Transfers.Transfer
  alias OtpConcurrencyEx.Repo

  def run do
    Logger.info("Running TransferenciasDevSeeds seeds...")
    Enum.each(transferencias(), &insert_or_update!/1)
    Logger.info("Running TransferenciasDevSeeds seeds... Done!")
  end

  defp insert_or_update!(attrs) do
    params = %{
      etapa: attrs.etapa
    }

    struct =
      case Transfers.get_by(params) do
        nil -> %Transfer{}
        transferencia -> transferencia
      end

    struct
    |> Transfer.changeset(attrs)
    |> Repo.insert_or_update!()
  end

  defp transferencias do
    [
      %{
        status: "aguardando_confirmacao",
        etapa: "analise_do_recebimento",
        valor: 30_000
      },
      %{
        status: "aguardando_pagamento",
        etapa: "analise_do_contrato",
        valor: 10_000
      },
      %{
        status: "falha",
        etapa: "analise_da_instalacao",
        valor: 20_000
      },
      %{
        status: "concluido",
        etapa: "analise_do_pagamento",
        valor: 3_000
      },
      %{
        status: "aguardando_confirmacao",
        etapa: "em_analise",
        valor: 5_000
      }
    ]
  end
end
