defmodule OtpConcurrencyEx.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OtpConcurrencyEx.Repo,
      GenServer.StartObtainingTransfer
    ]

    opts = [strategy: :one_for_one, name: OtpConcurrencyEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
