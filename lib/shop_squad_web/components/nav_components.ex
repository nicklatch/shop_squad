defmodule ShopSquadWeb.NavComponents do
  use Phoenix.Component

  attr :route, :string, required: true
  attr :link_text, :string, required: true

  def side_nav_link(assigns) do
    ~H"""
    <.link id={"#{@route}-link"} navigate={@route} class={"block md:text-2xl w-full rounded"}><%= @link_text%></.link>
    """
  end
end
