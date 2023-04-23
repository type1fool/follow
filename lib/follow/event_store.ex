defmodule Follow.EventStore do
  @moduledoc """
  Postgres event store for `Commanded`.
  """
  use EventStore, otp_app: :follow
end
