defmodule ShopSquadWeb.RepairOrdersLiveTest do
  use ShopSquadWeb.ConnCase

  import Phoenix.LiveViewTest
  import ShopSquad.RepairFixtures

  @create_attrs %{
    status: :Yard,
    total: Decimal.new("0.0")
  }
  @update_attrs %{
    closed: "2024-05-09T02:03:00Z",
    status: :Repair,
    total: Decimal.new("43.00")
  }
  @invalid_attrs %{closed: nil, status: nil, total: nil}

  defp create_repair_orders(_) do
    repair_orders = repair_orders_fixture()
    %{repair_orders: repair_orders}
  end

  describe "Index" do
    setup [:create_repair_orders, :register_and_log_in_user]

    test "lists all repair_orders", %{conn: conn, repair_orders: repair_orders} do
      {:ok, _index_live, html} = live(conn, ~p"/repair_orders")

      assert html =~ "Listing Repair orders"
      assert html =~ Atom.to_string(repair_orders.status)
    end

    test "saves new repair_orders", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/repair_orders")

      assert index_live |> element("a", "New Repair orders") |> render_click() =~
               "New Repair orders"

      assert_patch(index_live, ~p"/repair_orders/new")

      # assert index_live
      #        |> form("#repair_orders-form", repair_orders: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#repair_orders-form", repair_orders: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/repair_orders")

      html = render(index_live)
      assert html =~ "Repair orders created successfully"
      assert html =~ "Yard"
    end

    test "updates repair_orders in listing", %{conn: conn, repair_orders: repair_orders} do
      {:ok, index_live, _html} = live(conn, ~p"/repair_orders")

      assert index_live
             |> element("#repair_orders_collection-#{repair_orders.id} a", "Edit")
             |> render_click() =~
               "Edit Repair orders"

      assert_patch(index_live, ~p"/repair_orders/#{repair_orders}/edit")

      # assert index_live
      #        |> form("#repair_orders-form", repair_orders: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#repair_orders-form", repair_orders: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/repair_orders")

      html = render(index_live)
      assert html =~ "Repair orders updated successfully"
      assert html =~ "Repair"
    end

    test "deletes repair_orders in listing", %{conn: conn, repair_orders: repair_orders} do
      {:ok, index_live, _html} = live(conn, ~p"/repair_orders")

      assert index_live
             |> element("#repair_orders_collection-#{repair_orders.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#repair_orders-#{repair_orders.id}")
    end
  end

  describe "Show" do
    setup [:create_repair_orders, :register_and_log_in_user]

    test "displays repair_orders", %{conn: conn, repair_orders: repair_orders} do
      {:ok, _show_live, html} = live(conn, ~p"/repair_orders/#{repair_orders}")

      assert html =~ "Show Repair orders"
      assert html =~ Atom.to_string(repair_orders.status)
    end

    test "updates repair_orders within modal", %{conn: conn, repair_orders: repair_orders} do
      {:ok, show_live, _html} = live(conn, ~p"/repair_orders/#{repair_orders}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Repair orders"

      assert_patch(show_live, ~p"/repair_orders/#{repair_orders}/show/edit")

      # assert show_live
      #        |> form("#repair_orders-form", repair_orders: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#repair_orders-form", repair_orders: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/repair_orders/#{repair_orders}")

      html = render(show_live)
      assert html =~ "Repair orders updated successfully"
      assert html =~ "Repair"
    end
  end
end
