defmodule ShopSquad.RepairFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShopSquad.Repair` context.
  """

  @doc """
  Generate a repair_orders.
  """
  def repair_orders_fixture(attrs \\ %{}) do
    {:ok, repair_orders} =
      attrs
      |> Enum.into(%{
        closed: ~U[2024-05-08 02:03:00Z],
        status: :Repair,
        total: Decimal.new("0.0")
      })
      |> ShopSquad.Repair.create_repair_orders()

    repair_orders
  end

  @doc """
  Generate a repair_order_line.
  """
  def repair_order_line_fixture(attrs \\ %{}) do
    {:ok, repair_order_line} =
      attrs
      |> Enum.into(%{
        area: "some area",
        core_cost: "120.5",
        labor_cost: "120.5",
        notes: "some notes",
        parts_cost: "120.5",
        status: "some status",
        story: "some story",
        total_cost: Decimal.new("120.5"),
        repair_order_id: 1
      })
      |> ShopSquad.Repair.create_repair_order_line()

    repair_order_line
  end
end
