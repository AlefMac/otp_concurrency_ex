defmodule OtpConcurrencyEx.Repo do
  use Ecto.Repo,
    otp_app: :otp_concurrency_ex,
    adapter: Ecto.Adapters.Postgres
end
