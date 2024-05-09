defmodule ShopSquad.Repo do
  use Ecto.Repo,
    otp_app: :shop_squad,
    adapter: Ecto.Adapters.SQLite3
end
