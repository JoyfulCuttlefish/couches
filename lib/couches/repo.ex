defmodule Couches.Repo do
  use Ecto.Repo,
    otp_app: :couches,
    adapter: Ecto.Adapters.Postgres
end
