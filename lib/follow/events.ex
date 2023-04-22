defmodule Follow.Events do
  use Commanded.Application,
    otp_app: :follow,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Follow.EventStore
    ],
    pubsub: :local,
    registry: :local

  router(Follow.Routers.AccountRouter)
end
