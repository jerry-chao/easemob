defmodule Easemob.Repo do
  use Ecto.Repo,
    otp_app: :easemob,
    adapter: Ecto.Adapters.MyXQL
end
