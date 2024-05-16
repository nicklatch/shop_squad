defmodule ShopSquad.Repo.Migrations.ChangeRepairOrderTotalToDecimal do
  use Ecto.Migration

  def change do
    alter table("repair_orders") do
      remove :total_dollars
      remove :total_cents
      add :total, :decimal, precision: 15, scale: 6, null: false, default: 0.0
    end
  end
end
