defmodule Follow.Subscriptions.Projector do
  use Commanded.Projections.Ecto,
    application: Follow.Events,
    repo: Follow.Repo,
    name: "subscription_projection"

  alias Follow.Subscriptions.Events.Created
  alias Follow.Subscriptions.Events.Updated
  alias Follow.Subscriptions.Projection

  project %Created{user_id: user_id, initial_status: status},
          _metadata,
          fn multi ->
            Ecto.Multi.insert(multi, :subscription_projection, %Projection{
              user_id: user_id,
              status: status
            })
          end

  project %Updated{user_id: user_id, new_status: status},
          _metadata,
          fn multi ->
            case Follow.Repo.get(Projection, user_id) do
              nil ->
                multi

              sub ->
                status = String.to_existing_atom(status)
                attrs = %{user_id: user_id, status: status}

                Ecto.Multi.update(
                  multi,
                  :subscription_projection,
                  Projection.changeset(sub, attrs)
                )
            end
          end
end
