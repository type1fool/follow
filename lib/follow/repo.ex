defmodule Follow.Repo do
  use Ecto.Repo,
    otp_app: :follow,
    adapter: Ecto.Adapters.Postgres
end
