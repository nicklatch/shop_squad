defmodule ShopSquad.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :name, :string
    field :state, :string
    field :extension, :string
    field :address_one, :string
    field :address_two, :string
    field :city, :string
    field :postal_code, :integer
    field :country, :string
    field :email, :string
    field :phone, :string

    has_many :trucks, ShopSquad.Assets.Truck

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :name,
      :address_one,
      :address_two,
      :city,
      :state,
      :postal_code,
      :country,
      :email,
      :phone,
      :extension
    ])
    |> validate_required([
      :name,
      :address_one,
      :city,
      :state,
      :postal_code,
      :country,
      :email,
      :phone
    ])
    |> unique_constraint(:name)
  end
end
