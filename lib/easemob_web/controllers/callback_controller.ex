defmodule EasemobWeb.CallbackController do
  use EasemobWeb, :controller

  action_fallback EasemobWeb.FallbackController

  def postcallback(conn, params) do
    json(conn, %{valid: true, data: params})
  end

end
