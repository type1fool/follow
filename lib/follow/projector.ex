defmodule Follow.Projector do
  use Commanded.Projections.Ecto,
    application: Follow.Events,
    repo: Follow.Repo,
    name: "subscription_projection"

  alias Follow.Events.SubscriptionCreated
  alias Follow.Projections.SubscriptionProjection

  project %SubscriptionCreated{user_id: user_id, initial_status: status}, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :subscription_projection, %SubscriptionProjection{
      user_id: user_id,
      status: status
    })
  end
end
