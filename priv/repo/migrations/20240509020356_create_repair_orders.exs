defmodule ShopSquad.Repo.Migrations.CreateRepairOrders do
  use Ecto.Migration

  def change do
    create table(:repair_orders) do
      add :closed, :utc_datetime
      add :status, :string, null: false
      add :total_dollars, :integer, null: false, default: 0
      add :total_cents, :integer, null: false, default: 0
      add :customer_id, references(:customers, on_delete: :nothing)
      add :truck_id, references(:trucks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:repair_orders, [:customer_id])
    create index(:repair_orders, [:truck_id])
  end
end
