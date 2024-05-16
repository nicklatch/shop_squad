defmodule ShopSquadWeb.RepairOrdersLive.FormComponent do
  use ShopSquadWeb, :live_component

  alias ShopSquad.Repair

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage repair_orders records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="repair_orders-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <%= if String.contains?(@title, "Edit") do %>
          <.input field={@form[:closed]} type="datetime-local" label="Closed" />
        <% end %>
        <.input field={@form[:status]} type="select" label="Status" options={@status_opts} />
        <.input field={@form[:total]} type="number" label="Total" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Repair orders</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{repair_orders: repair_orders} = assigns, socket) do
    changeset = Repair.change_repair_orders(repair_orders)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:status_opts, Ecto.Enum.mappings(ShopSquad.Repair.RepairOrders, :status))
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"repair_orders" => repair_orders_params}, socket) do
    changeset =
      socket.assigns.repair_orders
      |> Repair.change_repair_orders(repair_orders_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"repair_orders" => repair_orders_params}, socket) do
    save_repair_orders(socket, socket.assigns.action, repair_orders_params)
  end

  defp save_repair_orders(socket, :edit, repair_orders_params) do
    case Repair.update_repair_orders(socket.assigns.repair_orders, repair_orders_params) do
      {:ok, repair_orders} ->
        notify_parent({:saved, repair_orders})

        {:noreply,
         socket
         |> put_flash(:info, "Repair orders updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_repair_orders(socket, :new, repair_orders_params) do
    case Repair.create_repair_orders(repair_orders_params) do
      {:ok, repair_orders} ->
        notify_parent({:saved, repair_orders})

        {:noreply,
         socket
         |> put_flash(:info, "Repair orders created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
