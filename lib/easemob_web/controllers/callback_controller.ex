defmodule EasemobWeb.CallbackController do
  use EasemobWeb, :controller

  alias Easemob.Messages

  action_fallback EasemobWeb.FallbackController

  def postcallback(conn, params) do
    Messages.send(params)
    json(conn, %{valid: true})
  end

end
