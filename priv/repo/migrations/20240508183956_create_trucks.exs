defmodule ShopSquad.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :vin, :string, null: false
      add :unit_number, :string
      add :model_year, :integer, null: false
      add :make, :string, null: false
      add :model, :string, null: false
      add :odometer, :integer, null: false
      add :engine_hours, :integer
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:trucks, [:vin])
    create index(:trucks, [:customer_id])
  end
end
