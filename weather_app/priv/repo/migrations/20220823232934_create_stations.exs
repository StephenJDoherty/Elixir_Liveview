defmodule WeatherApp.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :postalcode, :string
      add :name, :string

      timestamps()
    end
  end
end
