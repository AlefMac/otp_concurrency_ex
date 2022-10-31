defmodule OtpConcurrencyEx.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transfers" do
    field :etapa, :string
    field :status, :string
    field :valor, :float

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:etapa, :status, :valor])
    |> validate_required([:etapa, :status, :valor])
  end
end
