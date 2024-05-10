defmodule ShopSquad.RepairTest do
  use ShopSquad.DataCase

  alias ShopSquad.Repair

  describe "repair_orders" do
    alias ShopSquad.Repair.RepairOrders

    import ShopSquad.RepairFixtures

    @invalid_attrs %{closed: nil, status: nil, total_dollars: nil, total_cents: nil}

    test "list_repair_orders/0 returns all repair_orders" do
      repair_orders = repair_orders_fixture()
      assert Repair.list_repair_orders() == [repair_orders]
    end

    test "get_repair_orders!/1 returns the repair_orders with given id" do
      repair_orders = repair_orders_fixture()
      assert Repair.get_repair_orders!(repair_orders.id) == repair_orders
    end

    test "create_repair_orders/1 with valid data creates a repair_orders" do
      valid_attrs = %{closed: ~U[2024-05-08 02:03:00Z], status: "some status", total_dollars: 42, total_cents: 42}

      assert {:ok, %RepairOrders{} = repair_orders} = Repair.create_repair_orders(valid_attrs)
      assert repair_orders.closed == ~U[2024-05-08 02:03:00Z]
      assert repair_orders.status == "some status"
      assert repair_orders.total_dollars == 42
      assert repair_orders.total_cents == 42
    end

    test "create_repair_orders/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repair.create_repair_orders(@invalid_attrs)
    end

    test "update_repair_orders/2 with valid data updates the repair_orders" do
      repair_orders = repair_orders_fixture()
      update_attrs = %{closed: ~U[2024-05-09 02:03:00Z], status: "some updated status", total_dollars: 43, total_cents: 43}

      assert {:ok, %RepairOrders{} = repair_orders} = Repair.update_repair_orders(repair_orders, update_attrs)
      assert repair_orders.closed == ~U[2024-05-09 02:03:00Z]
      assert repair_orders.status == "some updated status"
      assert repair_orders.total_dollars == 43
      assert repair_orders.total_cents == 43
    end

    test "update_repair_orders/2 with invalid data returns error changeset" do
      repair_orders = repair_orders_fixture()
      assert {:error, %Ecto.Changeset{}} = Repair.update_repair_orders(repair_orders, @invalid_attrs)
      assert repair_orders == Repair.get_repair_orders!(repair_orders.id)
    end

    test "delete_repair_orders/1 deletes the repair_orders" do
      repair_orders = repair_orders_fixture()
      assert {:ok, %RepairOrders{}} = Repair.delete_repair_orders(repair_orders)
      assert_raise Ecto.NoResultsError, fn -> Repair.get_repair_orders!(repair_orders.id) end
    end

    test "change_repair_orders/1 returns a repair_orders changeset" do
      repair_orders = repair_orders_fixture()
      assert %Ecto.Changeset{} = Repair.change_repair_orders(repair_orders)
    end
  end
end
