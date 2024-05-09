defmodule ShopSquadWeb.CustomerLiveTest do
  use ShopSquadWeb.ConnCase

  import Phoenix.LiveViewTest
  import ShopSquad.CustomersFixtures

  @create_attrs %{
    name: "some name",
    state: "some state",
    extension: "some extension",
    address_one: "some address_one",
    address_two: "some address_two",
    city: "some city",
    postal_code: 42,
    country: "some country",
    email: "some email",
    phone: "some phone"
  }
  @update_attrs %{
    name: "some updated name",
    state: "some updated state",
    extension: "some updated extension",
    address_one: "some updated address_one",
    address_two: "some updated address_two",
    city: "some updated city",
    postal_code: 43,
    country: "some updated country",
    email: "some updated email",
    phone: "some updated phone"
  }
  @invalid_attrs %{
    name: nil,
    state: nil,
    extension: nil,
    address_one: nil,
    address_two: nil,
    city: nil,
    postal_code: nil,
    country: nil,
    email: nil,
    phone: nil
  }

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end

  describe "Index" do
    setup [:create_customer, :register_and_log_in_user]

    test "lists all customers", %{conn: conn, customer: customer} do
      {:ok, _index_live, html} = live(conn, ~p"/customers")

      assert html =~ "Listing Customers"
      assert html =~ customer.name
    end

    test "saves new customer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("a", "New Customer") |> render_click() =~
               "New Customer"

      assert_patch(index_live, ~p"/customers/new")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#customer-form", customer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer created successfully"
      assert html =~ "some name"
    end

    test "updates customer in listing", %{conn: conn, customer: customer} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("#customers-#{customer.id} a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(index_live, ~p"/customers/#{customer}/edit")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#customer-form", customer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes customer in listing", %{conn: conn, customer: customer} do
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("#customers-#{customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#customers-#{customer.id}")
    end
  end

  describe "Show" do
    setup [:create_customer, :register_and_log_in_user]

    test "displays customer", %{conn: conn, customer: customer} do
      {:ok, _show_live, html} = live(conn, ~p"/customers/#{customer}")

      assert html =~ "Show Customer"
      assert html =~ customer.name
    end

    test "updates customer within modal", %{conn: conn, customer: customer} do
      {:ok, show_live, _html} = live(conn, ~p"/customers/#{customer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(show_live, ~p"/customers/#{customer}/show/edit")

      assert show_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#customer-form", customer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/customers/#{customer}")

      html = render(show_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated name"
    end
  end
end
