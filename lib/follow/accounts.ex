defmodule Follow.Accounts do
  use Commanded.Application,
    otp_app: :follow,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Follow.EventStore
    ]

  router(Follow.AccountRouter)
end
