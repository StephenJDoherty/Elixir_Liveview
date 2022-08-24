defmodule WeatherApp.WeatherTest do
  use WeatherApp.DataCase

  alias WeatherApp.Weather

  describe "stations" do
    alias WeatherApp.Weather.Station

    import WeatherApp.WeatherFixtures

    @invalid_attrs %{name: nil, postalcode: nil}

    test "list_stations/0 returns all stations" do
      station = station_fixture()
      assert Weather.list_stations() == [station]
    end

    test "get_station!/1 returns the station with given id" do
      station = station_fixture()
      assert Weather.get_station!(station.id) == station
    end

    test "create_station/1 with valid data creates a station" do
      valid_attrs = %{name: "some name", postalcode: "some postalcode"}

      assert {:ok, %Station{} = station} = Weather.create_station(valid_attrs)
      assert station.name == "some name"
      assert station.postalcode == "some postalcode"
    end

    test "create_station/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weather.create_station(@invalid_attrs)
    end

    test "update_station/2 with valid data updates the station" do
      station = station_fixture()
      update_attrs = %{name: "some updated name", postalcode: "some updated postalcode"}

      assert {:ok, %Station{} = station} = Weather.update_station(station, update_attrs)
      assert station.name == "some updated name"
      assert station.postalcode == "some updated postalcode"
    end

    test "update_station/2 with invalid data returns error changeset" do
      station = station_fixture()
      assert {:error, %Ecto.Changeset{}} = Weather.update_station(station, @invalid_attrs)
      assert station == Weather.get_station!(station.id)
    end

    test "delete_station/1 deletes the station" do
      station = station_fixture()
      assert {:ok, %Station{}} = Weather.delete_station(station)
      assert_raise Ecto.NoResultsError, fn -> Weather.get_station!(station.id) end
    end

    test "change_station/1 returns a station changeset" do
      station = station_fixture()
      assert %Ecto.Changeset{} = Weather.change_station(station)
    end
  end
end
