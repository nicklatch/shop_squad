defmodule ShopSquadWeb.RepairOrdersLive.Index do
  use ShopSquadWeb, :live_view

  alias ShopSquad.Repair
  alias ShopSquad.Repair.RepairOrders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :repair_orders_collection, Repair.list_repair_orders())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Repair orders")
    |> assign(:repair_orders, Repair.get_repair_orders!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Repair orders")
    |> assign(:repair_orders, %RepairOrders{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Repair orders")
    |> assign(:repair_orders, nil)
  end

  @impl true
  def handle_info({ShopSquadWeb.RepairOrdersLive.FormComponent, {:saved, repair_orders}}, socket) do
    {:noreply, stream_insert(socket, :repair_orders_collection, repair_orders)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    repair_orders = Repair.get_repair_orders!(id)
    {:ok, _} = Repair.delete_repair_orders(repair_orders)

    {:noreply, stream_delete(socket, :repair_orders_collection, repair_orders)}
  end
end
