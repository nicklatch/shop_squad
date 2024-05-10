# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShopSquad.Repo.insert!(%ShopSquad.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

samples = [
  %{
    name: "ABC Trucking",
    state: "MN",
    address_one: "123 1st St.",
    city: "Bloomington",
    postal_code: 55245,
    country: "USA",
    email: "abc@abc.com",
    phone: "123-456-7899"
  },
  %{
    name: "Test Transport",
    state: "MN",
    address_one: "1225 9th Ave.",
    city: "Burnsville",
    postal_code: 55337,
    country: "USA",
    email: "test@test_trans.com",
    phone: "225-466-7999"
  },
  %{
    name: "Sample Lines",
    state: "ND",
    address_one: "3425 9 1/4 29th St.",
    city: "Fargo",
    postal_code: 58102,
    country: "USA",
    email: "sample@sample-lines.com",
    phone: "702-899-7099"
  }
]

for cust <- samples do
  {:ok, _} = ShopSquad.Customers.create_customer(cust)
end
