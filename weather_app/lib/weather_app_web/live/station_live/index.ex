defmodule WeatherAppWeb.StationLive.Index do
  use WeatherAppWeb, :live_view

  alias WeatherApp.Weather
  alias WeatherApp.Weather.Station

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(WeatherApp.PubSub, "stations")
    end
    {:ok, assign(socket, :stations, list_stations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Station")
    |> assign(:station, Weather.get_station!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Station")
    |> assign(:station, %Station{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stations")
    |> assign(:station, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    station = Weather.get_station!(id)
    {:ok, _} = Weather.delete_station(station)

    {:noreply, assign(socket, :stations, list_stations())}
  end

  def handle_info(_station, socket) do
    {:noreply, assign(socket, :stations, list_stations())}
  end

  defp list_stations do
    Weather.list_stations()
  end
end
