defmodule Follow.SubscriptionProjection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Follow.SubscriptionAggregate

  @statuses SubscriptionAggregate.get_statuses()

  @primary_key {:user_id, :id, autogenerate: false}
  schema "subscription_projections" do
    field :status, Ecto.Enum, values: @statuses
  end

  def update_changeset(%__MODULE__{} = data, attrs) do
    data
    |> cast(attrs, [:user_id, :status])
    |> validate_required(__MODULE__.__schema__(:fields))
  end
end
