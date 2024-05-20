defmodule ShopSquadWeb.RepairOrdersLive.FormComponent do
  use ShopSquadWeb, :live_component

  alias ShopSquad.Repair
  alias ShopSquad.Customers
  alias ShopSquad.Assets

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
        <.input field={@form[:status]} type="select" label="Status" options={@status_opts} />
        <%= if String.contains?(@title, "Edit") do %>
          <.input field={@form[:closed]} type="datetime-local" label="Closed" />
          <.input field={@form[:total]} type="number" label="Total" disabled />
        <% end %>
        <%= if !String.contains?(@title, "Edit")do %>
          <.input field={@form[:customer_id]} type="select" label="Customer" options={@customer_opts} />
          <.input field={@form[:truck_id]} type="select" label="Truck" options={@truck_opts} />
        <% end %>
        <.input field={@form[:engine_hours]} type="number" label="Engine Hours" />
        <.input field={@form[:odometer]} type="number" label="Odometer" />

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
     |> assign(:status_opts, Ecto.Enum.mappings(Repair.RepairOrders, :status))
     |> assign(:customer_opts, customer_opts())
     |> assign(:truck_opts, truck_opts())
     |> assign_form(changeset)}
  end

  defp customer_opts, do: Customers.get_customer_options()

  defp truck_opts(), do: Assets.list_truck_ids_and_vins()
  defp truck_opts(id), do: Assets.get_trucks_by_customer_id(id)

  @impl true
  def handle_event("validate", %{"repair_orders" => repair_orders_params}, socket) do
    socket = assign(socket, :truck_opts, truck_opts(repair_orders_params["customer_id"]))

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
