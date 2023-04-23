defmodule Follow.EventRouter do
  use Commanded.Commands.Router
  alias Follow.Subscriptions

  dispatch(Subscriptions.Commands.Create, to: Subscriptions.Aggregate, identity: :user_id)
  dispatch(Subscriptions.Commands.Update, to: Subscriptions.Aggregate, identity: :user_id)
end
