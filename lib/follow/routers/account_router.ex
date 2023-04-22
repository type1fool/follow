defmodule Follow.Routers.AccountRouter do
  use Commanded.Commands.Router
  alias Follow.Aggregates.SubscriptionAggregate
  alias Follow.Commands.CreateSubscription

  dispatch(CreateSubscription, to: SubscriptionAggregate, identity: :user_id)
end
