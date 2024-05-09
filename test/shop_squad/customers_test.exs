defmodule ShopSquad.CustomersTest do
  use ShopSquad.DataCase

  alias ShopSquad.Customers

  describe "customers" do
    alias ShopSquad.Customers.Customer

    import ShopSquad.CustomersFixtures

    @invalid_attrs %{name: nil, state: nil, extension: nil, address_one: nil, address_two: nil, city: nil, postal_code: nil, country: nil, email: nil, phone: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{name: "some name", state: "some state", extension: "some extension", address_one: "some address_one", address_two: "some address_two", city: "some city", postal_code: 42, country: "some country", email: "some email", phone: "some phone"}

      assert {:ok, %Customer{} = customer} = Customers.create_customer(valid_attrs)
      assert customer.name == "some name"
      assert customer.state == "some state"
      assert customer.extension == "some extension"
      assert customer.address_one == "some address_one"
      assert customer.address_two == "some address_two"
      assert customer.city == "some city"
      assert customer.postal_code == 42
      assert customer.country == "some country"
      assert customer.email == "some email"
      assert customer.phone == "some phone"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{name: "some updated name", state: "some updated state", extension: "some updated extension", address_one: "some updated address_one", address_two: "some updated address_two", city: "some updated city", postal_code: 43, country: "some updated country", email: "some updated email", phone: "some updated phone"}

      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, update_attrs)
      assert customer.name == "some updated name"
      assert customer.state == "some updated state"
      assert customer.extension == "some updated extension"
      assert customer.address_one == "some updated address_one"
      assert customer.address_two == "some updated address_two"
      assert customer.city == "some updated city"
      assert customer.postal_code == 43
      assert customer.country == "some updated country"
      assert customer.email == "some updated email"
      assert customer.phone == "some updated phone"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
