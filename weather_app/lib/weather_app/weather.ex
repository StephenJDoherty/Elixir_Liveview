defmodule WeatherApp.Weather do
  @moduledoc """
  The Weather context.
  """

  import Ecto.Query, warn: false
  alias WeatherApp.Repo

  alias WeatherApp.Weather.Station

  @doc """
  Returns the list of stations.

  ## Examples

      iex> list_stations()
      [%Station{}, ...]

  """
  def list_stations do
    Repo.all(Station)
  end

  @doc """
  Gets a single station.

  Raises `Ecto.NoResultsError` if the Station does not exist.

  ## Examples

      iex> get_station!(123)
      %Station{}

      iex> get_station!(456)
      ** (Ecto.NoResultsError)

  """
  def get_station!(id), do: Repo.get!(Station, id)

  @doc """
  Creates a station.

  ## Examples

      iex> create_station(%{field: value})
      {:ok, %Station{}}

      iex> create_station(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_station(attrs \\ %{}) do
    %Station{}
    |> Station.changeset(attrs)
    |> Repo.insert()
    |> publish_station()
  end

  @doc """
  Updates a station.

  ## Examples

      iex> update_station(station, %{field: new_value})
      {:ok, %Station{}}

      iex> update_station(station, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_station(%Station{} = station, attrs) do
    station
    |> Station.changeset(attrs)
    |> Repo.update()
    |> publish_station()
  end

  @doc """
  Deletes a station.

  ## Examples

      iex> delete_station(station)
      {:ok, %Station{}}

      iex> delete_station(station)
      {:error, %Ecto.Changeset{}}

  """
  def delete_station(%Station{} = station) do
    Repo.delete(station)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking station changes.

  ## Examples

      iex> change_station(station)
      %Ecto.Changeset{data: %Station{}}

  """
  def change_station(%Station{} = station, attrs \\ %{}) do
    Station.changeset(station, attrs)
  end

  defp publish_station({:error, _} = result), do: result
  defp publish_station({:ok, station}) do
    Phoenix.PubSub.broadcast(WeatherApp.PubSub, "stations", station)

    {:ok, station}
  end
end
