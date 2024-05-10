defmodule ShopSquad.AssetsTest do
  use ShopSquad.DataCase

  alias ShopSquad.Assets

  describe "trucks" do
    alias ShopSquad.Assets.Truck

    import ShopSquad.AssetsFixtures

    @some_vin "1XKYDP9X2RJ360169"
    @some_updated_vin "1XKYDP9X2RJ360171"

    @invalid_attrs %{
      make: nil,
      vin: nil,
      unit_number: nil,
      model_year: nil,
      model: nil,
      odometer: nil,
      engine_hours: nil
    }

    test "list_trucks/0 returns all trucks" do
      truck = truck_fixture()
      assert Assets.list_trucks() == [truck]
    end

    test "get_truck!/1 returns the truck with given id" do
      truck =
        truck_fixture()
        |> Map.update!(:customer, fn _ -> nil end)

      assert Assets.get_truck!(truck.id) == truck
    end

    test "create_truck/1 with valid data creates a truck" do
      valid_attrs = %{
        make: :Volvo,
        vin: @some_vin,
        unit_number: "some unit_number",
        model_year: 2021,
        model: "some model",
        odometer: 42,
        engine_hours: 42
      }

      assert {:ok, %Truck{} = truck} = Assets.create_truck(valid_attrs)
      assert truck.make == :Volvo
      assert truck.vin == @some_vin
      assert truck.unit_number == "some unit_number"
      assert truck.model_year == 2021
      assert truck.model == "some model"
      assert truck.odometer == 42
      assert truck.engine_hours == 42
    end

    test "create_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_truck(@invalid_attrs)
    end

    test "update_truck/2 with valid data updates the truck" do
      truck =
        truck_fixture()
        |> Map.update!(:customer, fn _ -> nil end)

      update_attrs = %{
        make: :Peterbilt,
        vin: @some_updated_vin,
        unit_number: "some updated unit_number",
        model_year: 2024,
        model: "579",
        odometer: 43,
        engine_hours: 43
      }

      assert {:ok, %Truck{} = truck} = Assets.update_truck(truck, update_attrs)
      assert truck.make == :Peterbilt
      assert truck.vin == @some_updated_vin
      assert truck.unit_number == "some updated unit_number"
      assert truck.model_year == 2024
      assert truck.model == "579"
      assert truck.odometer == 43
      assert truck.engine_hours == 43
    end

    test "update_truck/2 with invalid data returns error changeset" do
      truck =
        truck_fixture()
        |> Map.update!(:customer, fn _ -> nil end)

      assert {:error, %Ecto.Changeset{}} = Assets.update_truck(truck, @invalid_attrs)
      assert truck == Assets.get_truck!(truck.id)
    end

    test "delete_truck/1 deletes the truck" do
      truck =
        truck_fixture()
        |> Map.update!(:customer, fn _ -> nil end)

      assert {:ok, %Truck{}} = Assets.delete_truck(truck)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_truck!(truck.id) end
    end

    test "change_truck/1 returns a truck changeset" do
      truck =
        truck_fixture()
        |> Map.update!(:customer, fn _ -> nil end)

      assert %Ecto.Changeset{} = Assets.change_truck(truck)
    end
  end
end
