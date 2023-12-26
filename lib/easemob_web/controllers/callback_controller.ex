defmodule EasemobWeb.CallbackController do
  use EasemobWeb, :controller

  action_fallback EasemobWeb.FallbackController

  def postcallback(conn, _params) do
    json(conn, %{"status" => "ok"})
  end

end
