defmodule ShopSquad.Repo.Migrations.CreateRepairOrderLines do
  use Ecto.Migration

  def change do
    create table(:repair_order_lines) do
      add :status, :string, null: false
      add :area, :string, null: false
      add :story, :string, null: false
      add :notes, :string
      add :labor_cost, :decimal, precision: 15, scale: 6, null: false, default: 0.0
      add :parts_cost, :decimal, precision: 15, scale: 6, null: false, default: 0.0
      add :core_cost, :decimal, precision: 15, scale: 6, null: false, default: 0.0
      add :total_cost, :decimal, precision: 15, scale: 6, null: false, default: 0.0
      add :repair_order_id, references(:repair_orders, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:repair_order_lines, [:repair_order_id])
  end
end
