defmodule OtpConcurrencyEx.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :etapa, :string
      add :status, :string
      add :valor, :float

      timestamps()
    end
  end
end
