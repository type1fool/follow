defmodule Follow.Repo.Migrations.AddProjections do
  use Ecto.Migration

  def change do
    create table(:subscription_projections, primary_key: false) do
      add :user_id, :id, primary_key: true
      add :status, :string
    end
  end
end
