defmodule EasemobWeb.CallbackControllerTest do
  use EasemobWeb.ConnCase

  import Easemob.MessagesFixtures

  alias Easemob.Messages.Callback

  @create_attrs %{
    from: "some from",
    message: "some message",
    to: "some to"
  }
  @update_attrs %{
    from: "some updated from",
    message: "some updated message",
    to: "some updated to"
  }
  @invalid_attrs %{from: nil, message: nil, to: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

end
