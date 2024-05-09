defmodule ShopSquad.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShopSquad.Customers` context.
  """

  @doc """
  Generate a unique customer name.
  """
  def unique_customer_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        address_one: "some address_one",
        address_two: "some address_two",
        city: "some city",
        country: "some country",
        email: "some email",
        extension: "some extension",
        name: unique_customer_name(),
        phone: "some phone",
        postal_code: 42,
        state: "some state"
      })
      |> ShopSquad.Customers.create_customer()

    customer
  end
end
