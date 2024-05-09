defmodule ShopSquad.Assets.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trucks" do
    field :make, Ecto.Enum,
      values: [
        :Kenworth,
        :Peterbilt,
        :Freightliner,
        :Western_Star,
        :Volvo,
        :Mack
      ]

    field :vin, :string
    field :unit_number, :string
    field :model_year, :integer
    field :model, :string
    field :odometer, :integer
    field :engine_hours, :integer

    belongs_to :customer, ShopSquad.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [:vin, :unit_number, :model_year, :make, :model, :odometer, :engine_hours])
    |> validate_required([
      :vin,
      :model_year,
      :make,
      :model,
      :odometer
    ])
    |> valdiate_model_year()
    |> unique_constraint(:vin)
  end

  @doc """
  Validates the model year of the given changeset.

  Truck model years (MY) are always build year + 1.
  So, a truck with a build year of 2024 is a 2025 model year.
  """
  @spec valdiate_model_year(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def valdiate_model_year(truck) do
    truck
    |> validate_inclusion(:model_year, 1932..(current_year() + 1))
  end

  defp current_year, do: Date.utc_today().year
end
