defmodule Follow.AccountRouter do
  use Commanded.Commands.Router
  alias Follow.Accounts.Subscription
  alias Follow.Accounts.CreateSubscription

  dispatch(CreateSubscription, to: Subscription, identity: :user_id)
end
