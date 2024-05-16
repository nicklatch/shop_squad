defmodule ShopSquad.Repair do
  @moduledoc """
  The Repair context.
  """

  import Ecto.Query, warn: false
  alias ShopSquad.Repo

  alias ShopSquad.Repair.RepairOrders

  @doc """
  Returns the list of repair_orders.

  ## Examples

      iex> list_repair_orders()
      [%RepairOrders{}, ...]

  """
  def list_repair_orders do
    Repo.all(RepairOrders)
  end

  @doc """
  Gets a single repair_orders.

  Raises `Ecto.NoResultsError` if the Repair orders does not exist.

  ## Examples

      iex> get_repair_orders!(123)
      %RepairOrders{}

      iex> get_repair_orders!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repair_orders!(id), do: Repo.get!(RepairOrders, id)

  @doc """
  Creates a repair_orders.

  ## Examples

      iex> create_repair_orders(%{field: value})
      {:ok, %RepairOrders{}}

      iex> create_repair_orders(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repair_orders(attrs \\ %{}) do
    %RepairOrders{}
    |> RepairOrders.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repair_orders.

  ## Examples

      iex> update_repair_orders(repair_orders, %{field: new_value})
      {:ok, %RepairOrders{}}

      iex> update_repair_orders(repair_orders, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repair_orders(%RepairOrders{} = repair_orders, attrs) do
    repair_orders
    |> RepairOrders.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repair_orders.

  ## Examples

      iex> delete_repair_orders(repair_orders)
      {:ok, %RepairOrders{}}

      iex> delete_repair_orders(repair_orders)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repair_orders(%RepairOrders{} = repair_orders) do
    Repo.delete(repair_orders)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repair_orders changes.

  ## Examples

      iex> change_repair_orders(repair_orders)
      %Ecto.Changeset{data: %RepairOrders{}}

  """
  def change_repair_orders(%RepairOrders{} = repair_orders, attrs \\ %{}) do
    RepairOrders.changeset(repair_orders, attrs)
  end

  alias ShopSquad.Repair.RepairOrderLine

  @doc """
  Returns the list of repair_order_lines.

  ## Examples

      iex> list_repair_order_lines()
      [%RepairOrderLine{}, ...]

  """
  def list_repair_order_lines do
    Repo.all(RepairOrderLine)
  end

  @doc """
  Gets a single repair_order_line.

  Raises `Ecto.NoResultsError` if the Repair order line does not exist.

  ## Examples

      iex> get_repair_order_line!(123)
      %RepairOrderLine{}

      iex> get_repair_order_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repair_order_line!(id), do: Repo.get!(RepairOrderLine, id)

  @doc """
  Creates a repair_order_line.

  ## Examples

      iex> create_repair_order_line(%{field: value})
      {:ok, %RepairOrderLine{}}

      iex> create_repair_order_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repair_order_line(attrs \\ %{}) do
    %RepairOrderLine{}
    |> RepairOrderLine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repair_order_line.

  ## Examples

      iex> update_repair_order_line(repair_order_line, %{field: new_value})
      {:ok, %RepairOrderLine{}}

      iex> update_repair_order_line(repair_order_line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repair_order_line(%RepairOrderLine{} = repair_order_line, attrs) do
    repair_order_line
    |> RepairOrderLine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repair_order_line.

  ## Examples

      iex> delete_repair_order_line(repair_order_line)
      {:ok, %RepairOrderLine{}}

      iex> delete_repair_order_line(repair_order_line)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repair_order_line(%RepairOrderLine{} = repair_order_line) do
    Repo.delete(repair_order_line)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repair_order_line changes.

  ## Examples

      iex> change_repair_order_line(repair_order_line)
      %Ecto.Changeset{data: %RepairOrderLine{}}

  """
  def change_repair_order_line(%RepairOrderLine{} = repair_order_line, attrs \\ %{}) do
    RepairOrderLine.changeset(repair_order_line, attrs)
  end
end
