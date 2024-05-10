defmodule ShopSquadWeb.CustomerLive.FormComponent do
  use ShopSquadWeb, :live_component

  alias ShopSquad.Customers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage customer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="customer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="text-white"
      >
        <.input field={@form[:name]} type="text" label="Name" class="text-gray-200 underline" />
        <.input field={@form[:address_one]} type="text" label="Address one" class="text-gray-200" />
        <.input field={@form[:address_two]} type="text" label="Address two" class="text-gray-200" />
        <.input field={@form[:city]} type="text" label="City" class="text-gray-200" />
        <.input field={@form[:state]} type="text" label="State" />
        <.input field={@form[:postal_code]} type="number" label="Postal code" class="text-gray-200" />
        <.input field={@form[:country]} type="text" label="Country" class="text-gray-200" />
        <.input field={@form[:email]} type="text" label="Email" class="text-gray-200" />
        <.input field={@form[:phone]} type="text" label="Phone" class="text-gray-200" />
        <.input field={@form[:extension]} type="text" label="Extension" class="text-gray-200" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Customer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{customer: customer} = assigns, socket) do
    changeset = Customers.change_customer(customer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"customer" => customer_params}, socket) do
    changeset =
      socket.assigns.customer
      |> Customers.change_customer(customer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"customer" => customer_params}, socket) do
    save_customer(socket, socket.assigns.action, customer_params)
  end

  defp save_customer(socket, :edit, customer_params) do
    case Customers.update_customer(socket.assigns.customer, customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_customer(socket, :new, customer_params) do
    case Customers.create_customer(customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer created successfully")
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
