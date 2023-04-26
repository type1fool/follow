defmodule Follow.Repo do
  @moduledoc """
  A Postgres database for CRUD data and aggregate event data.
  """
  use Ecto.Repo,
    otp_app: :follow,
    adapter: Ecto.Adapters.Postgres
end
