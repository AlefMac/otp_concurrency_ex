defmodule OtpConcurrencyEx.TransfersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OtpConcurrencyEx.Transfers` context.
  """

  @doc """
  Generate a transfer.
  """
  def transfer_fixture(attrs \\ %{}) do
    {:ok, transfer} =
      attrs
      |> Enum.into(%{
        etapa: "some etapa",
        status: "some status",
        valor: 120.5
      })
      |> OtpConcurrencyEx.Transfers.create_transfer()

    transfer
  end
end
