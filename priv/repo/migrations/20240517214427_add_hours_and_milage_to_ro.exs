defmodule ShopSquad.Repo.Migrations.AddHoursAndMilageToRO do
  use Ecto.Migration

  def change do
    alter table(:repair_orders) do
      add :odometer, :integer
      add :engine_hours, :integer
    end
  end
end
