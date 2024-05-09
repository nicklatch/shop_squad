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
        status: "some status",
        total_cents: 42,
        total_dollars: 42
      })
      |> ShopSquad.Repair.create_repair_orders()

    repair_orders
  end
end
