defmodule Follow.SubscriptionProjection do
  use Ecto.Schema

  schema "subscription_projections" do
    field :user_id, :id
    field :status, :string
  end
end
