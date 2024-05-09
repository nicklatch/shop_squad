defmodule ShopSquadWeb.RepairOrdersLive.Show do
  use ShopSquadWeb, :live_view

  alias ShopSquad.Repair

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:repair_orders, Repair.get_repair_orders!(id))}
  end

  defp page_title(:show), do: "Show Repair orders"
  defp page_title(:edit), do: "Edit Repair orders"
end
