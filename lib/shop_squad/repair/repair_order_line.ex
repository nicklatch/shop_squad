defmodule ShopSquad.Repair.RepairOrderLine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repair_order_lines" do
    field :status, :string
    field :area, :string
    field :story, :string
    field :notes, :string
    field :labor_cost, :decimal
    field :parts_cost, :decimal
    field :core_cost, :decimal
    field :total_cost, :decimal

    belongs_to :repair_order, ShopSquad.Repair.RepairOrders
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(repair_order_line, attrs) do
    repair_order_line
    |> cast(attrs, [:status, :area, :story, :notes, :labor_cost, :parts_cost, :core_cost, :total_cost, :repair_order_id])
    |> validate_required([:status, :area, :story, :labor_cost, :parts_cost, :core_cost, :total_cost, :repair_order_id])
  end
end
