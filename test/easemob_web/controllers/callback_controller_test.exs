defmodule EasemobWeb.CallbackControllerTest do
  use EasemobWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @create_callback %{
    callId: "1145230613161200#demo_d210f8f50bf7415d9e4dd73496e14297",
    timestamp: 1_694_398_161_077,
    chat_type: "chat",
    from: "143837689",
    to: "n___7717166",
    msg_id: "1188990232259724759",
    payload: %{
      bodies: [
        %{
          msg: "喜马拉雅造山运动由来",
          type: "txt"
        }
      ],
      ext: %{
        version: 2
      },
      from: "143837689",
      meta: %{},
      to: "n___7717166",
      type: "chat"
    },
    security: "d8e48d9495a0a0eb6878c4435102e9e2",
    app_id: "com.assistant.easemob"
  }

  describe "postcallback" do
    test "call postcallback", %{conn: conn} do
      conn = post(conn, ~p"/api/postcallback", @create_callback)
      assert %{"valid" => true} = json_response(conn, 200)
    end
  end
end
