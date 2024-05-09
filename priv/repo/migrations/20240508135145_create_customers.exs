defmodule ShopSquad.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string, null: false
      add :address_one, :string, null: false
      add :address_two, :string
      add :city, :string, null: false
      add :state, :string, null: false
      add :postal_code, :integer, null: false
      add :country, :string, null: false
      add :email, :string, null: false
      add :phone, :string, null: false
      add :extension, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:customers, [:name])
  end
end
