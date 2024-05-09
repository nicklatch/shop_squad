defmodule ShopSquad.AssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShopSquad.Assets` context.
  """

  @doc """
  Generate a unique truck vin.
  """
  def unique_truck_vin, do: "1XKZDP9X3MJ443333"

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        engine_hours: 2,
        make: :Kenworth,
        model: "T680",
        model_year: 2023,
        odometer: 42,
        unit_number: "69420",
        vin: unique_truck_vin()
      })
      |> ShopSquad.Assets.create_truck()

    truck
  end
end
