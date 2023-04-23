defmodule Follow.Projector do
  use Commanded.Projections.Ecto,
    application: Follow.Events,
    repo: Follow.Repo,
    name: "subscription_projection"

  alias Follow.SubscriptionCreatedEvent
  alias Follow.SubscriptionUpdatedEvent
  alias Follow.SubscriptionProjection

  project %SubscriptionCreatedEvent{user_id: user_id, initial_status: status},
          _metadata,
          fn multi ->
            Ecto.Multi.insert(multi, :subscription_projection, %SubscriptionProjection{
              user_id: user_id,
              status: status
            })
          end

  project %SubscriptionUpdatedEvent{user_id: user_id, new_status: status},
          _metadata,
          fn multi ->
            case Follow.Repo.get(SubscriptionProjection, user_id) do
              nil ->
                multi

              sub ->
                status = String.to_existing_atom(status)
                attrs = %{user_id: user_id, status: status}

                Ecto.Multi.update(
                  multi,
                  :subscription_projection,
                  SubscriptionProjection.update_changeset(sub, attrs)
                )
            end
          end
end
