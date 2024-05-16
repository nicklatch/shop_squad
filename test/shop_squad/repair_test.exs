defmodule ShopSquad.RepairTest do
  use ShopSquad.DataCase

  alias ShopSquad.Repair

  describe "repair_orders" do
    alias ShopSquad.Repair.RepairOrders

    import ShopSquad.RepairFixtures

    @invalid_attrs %{closed: nil, status: nil, total: nil}

    test "list_repair_orders/0 returns all repair_orders" do
      repair_orders = repair_orders_fixture()
      assert Repair.list_repair_orders() == [repair_orders]
    end

    test "get_repair_orders!/1 returns the repair_orders with given id" do
      repair_orders = repair_orders_fixture(%{total: Decimal.new("0")})
      assert Repair.get_repair_orders!(repair_orders.id) == repair_orders
    end

    test "create_repair_orders/1 with valid data creates a repair_orders" do
      valid_attrs = %{
        closed: ~U[2024-05-08 02:03:00Z],
        status: :Yard,
        total: Decimal.new("42.00")
      }

      assert {:ok, %RepairOrders{} = repair_orders} = Repair.create_repair_orders(valid_attrs)
      assert repair_orders.closed == ~U[2024-05-08 02:03:00Z]
      assert repair_orders.status == :Yard
      assert repair_orders.total == Decimal.new("42.00")
    end

    test "create_repair_orders/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repair.create_repair_orders(@invalid_attrs)
    end

    test "update_repair_orders/2 with valid data updates the repair_orders" do
      repair_orders = repair_orders_fixture()

      update_attrs = %{
        closed: ~U[2024-05-09 02:03:00Z],
        status: "Yard",
        total: Decimal.new("43.00")
      }

      assert {:ok, %RepairOrders{} = repair_orders} =
               Repair.update_repair_orders(repair_orders, update_attrs)

      assert repair_orders.closed == ~U[2024-05-09 02:03:00Z]
      assert Atom.to_string(repair_orders.status) == "Yard"
      assert repair_orders.total == Decimal.new("43.00")
    end

    test "update_repair_orders/2 with invalid data returns error changeset" do
      repair_orders = repair_orders_fixture(%{total: Decimal.new("0")})

      assert {:error, %Ecto.Changeset{}} =
               Repair.update_repair_orders(repair_orders, @invalid_attrs)

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

  describe "repair_order_lines" do
    alias ShopSquad.Repair.RepairOrderLine

    import ShopSquad.RepairFixtures

    @invalid_attrs %{
      status: nil,
      area: nil,
      story: nil,
      notes: nil,
      labor_cost: nil,
      parts_cost: nil,
      core_cost: nil,
      total_cost: nil,
      repair_order_id: 170
    }

    test "list_repair_order_lines/0 returns all repair_order_lines" do
      repair_order_line = repair_order_line_fixture()
      assert Repair.list_repair_order_lines() == [repair_order_line]
    end

    test "get_repair_order_line!/1 returns the repair_order_line with given id" do
      repair_order_line = repair_order_line_fixture()
      assert Repair.get_repair_order_line!(repair_order_line.id) == repair_order_line
    end

    test "create_repair_order_line/1 with valid data creates a repair_order_line" do
      valid_attrs = %{
        status: "some status",
        area: "some area",
        story: "some story",
        notes: "some notes",
        labor_cost: "120.5",
        parts_cost: "120.5",
        core_cost: "120.5",
        total_cost: "120.5",
        repair_order_id: 1
      }

      assert {:ok, %RepairOrderLine{} = repair_order_line} =
               Repair.create_repair_order_line(valid_attrs)

      assert repair_order_line.status == "some status"
      assert repair_order_line.area == "some area"
      assert repair_order_line.story == "some story"
      assert repair_order_line.notes == "some notes"
      assert repair_order_line.labor_cost == Decimal.new("120.5")
      assert repair_order_line.parts_cost == Decimal.new("120.5")
      assert repair_order_line.core_cost == Decimal.new("120.5")
      assert repair_order_line.total_cost == Decimal.new("120.5")
    end

    test "create_repair_order_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repair.create_repair_order_line(@invalid_attrs)
    end

    test "update_repair_order_line/2 with valid data updates the repair_order_line" do
      repair_order_line = repair_order_line_fixture()

      update_attrs = %{
        status: "some updated status",
        area: "some updated area",
        story: "some updated story",
        notes: "some updated notes",
        labor_cost: "456.7",
        parts_cost: "456.7",
        core_cost: "456.7",
        total_cost: "456.7"
      }

      assert {:ok, %RepairOrderLine{} = repair_order_line} =
               Repair.update_repair_order_line(repair_order_line, update_attrs)

      assert repair_order_line.status == "some updated status"
      assert repair_order_line.area == "some updated area"
      assert repair_order_line.story == "some updated story"
      assert repair_order_line.notes == "some updated notes"
      assert repair_order_line.labor_cost == Decimal.new("456.7")
      assert repair_order_line.parts_cost == Decimal.new("456.7")
      assert repair_order_line.core_cost == Decimal.new("456.7")
      assert repair_order_line.total_cost == Decimal.new("456.7")
    end

    test "update_repair_order_line/2 with invalid data returns error changeset" do
      repair_order_line = repair_order_line_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Repair.update_repair_order_line(repair_order_line, @invalid_attrs)

      assert repair_order_line == Repair.get_repair_order_line!(repair_order_line.id)
    end

    test "delete_repair_order_line/1 deletes the repair_order_line" do
      repair_order_line = repair_order_line_fixture()
      assert {:ok, %RepairOrderLine{}} = Repair.delete_repair_order_line(repair_order_line)

      assert_raise Ecto.NoResultsError, fn ->
        Repair.get_repair_order_line!(repair_order_line.id)
      end
    end

    test "change_repair_order_line/1 returns a repair_order_line changeset" do
      repair_order_line = repair_order_line_fixture()
      assert %Ecto.Changeset{} = Repair.change_repair_order_line(repair_order_line)
    end
  end
end
