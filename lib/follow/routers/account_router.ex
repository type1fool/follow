defmodule Follow.AccountRouter do
  use Commanded.Commands.Router
  alias Follow.SubscriptionAggregate
  alias Follow.CreateSubscriptionCommand
  alias Follow.UpdateSubscriptionCommand

  dispatch(CreateSubscriptionCommand, to: SubscriptionAggregate, identity: :user_id)
  dispatch(UpdateSubscriptionCommand, to: SubscriptionAggregate, identity: :user_id)
end
