defmodule Follow.Routers.AccountRouter do
  use Commanded.Commands.Router
  alias Follow.Aggregates.SubscriptionAggregate
  alias Follow.Commands.CreateSubscription

  dispatch(CreateSubscription, to: Subscription, identity: :user_id)
end
