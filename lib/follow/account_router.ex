defmodule Follow.AccountRouter do
  use Commanded.Commands.Router
  alias Follow.Aggregates.Subscription
  alias Follow.Commands.CreateSubscription

  dispatch(CreateSubscription, to: Subscription, identity: :user_id)
end
