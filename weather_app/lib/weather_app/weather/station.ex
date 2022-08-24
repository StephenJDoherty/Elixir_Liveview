defmodule WeatherApp.Weather.Station do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stations" do
    field :name, :string
    field :postalcode, :string

    timestamps()
  end

  @doc false
  def changeset(station, attrs) do
    station
    |> cast(attrs, [:postalcode, :name])
    |> validate_required([:postalcode, :name])
  end
end
