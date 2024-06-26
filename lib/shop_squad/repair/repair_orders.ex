defmodule ShopSquad.Repair.RepairOrders do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repair_orders" do
    field :closed, :utc_datetime
    field :status, Ecto.Enum, values: [:Yard, :Repair, :AuthHold, :PartsHold, :Complete]
    field :total, :decimal
    field :odometer, :integer
    field :engine_hours, :integer

    belongs_to :customer, ShopSquad.Customers.Customer
    belongs_to :truck, ShopSquad.Assets.Truck

    has_many :repair_order_lines, ShopSquad.Repair.RepairOrderLine

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(repair_orders, attrs) do
    repair_orders
    |> cast(attrs, [:closed, :status, :total, :odometer, :engine_hours])
    |> validate_required([:status, :odometer])
  end
end
