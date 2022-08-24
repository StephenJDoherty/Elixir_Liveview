defmodule WeatherApp.WeatherFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WeatherApp.Weather` context.
  """

  @doc """
  Generate a station.
  """
  def station_fixture(attrs \\ %{}) do
    {:ok, station} =
      attrs
      |> Enum.into(%{
        name: "some name",
        postalcode: "some postalcode"
      })
      |> WeatherApp.Weather.create_station()

    station
  end
end
