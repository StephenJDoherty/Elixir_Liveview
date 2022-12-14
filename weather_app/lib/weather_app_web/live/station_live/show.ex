defmodule WeatherAppWeb.StationLive.Show do
  use WeatherAppWeb, :live_view

  alias WeatherApp.Weather

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:station, Weather.get_station!(id))}
  end

  defp page_title(:show), do: "Show Station"
  defp page_title(:edit), do: "Edit Station"
end
