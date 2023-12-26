defmodule EasemobWeb.PrivateControllerTest do
  use EasemobWeb.ConnCase

  import Easemob.MessagesFixtures

  alias Easemob.Messages.Private

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

  describe "index" do
    test "lists all private", %{conn: conn} do
      conn = get(conn, ~p"/api/private")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create private" do
    test "renders private when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/private", private: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/private/#{id}")

      assert %{
               "id" => ^id,
               "from" => "some from",
               "message" => "some message",
               "to" => "some to"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/private", private: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update private" do
    setup [:create_private]

    test "renders private when data is valid", %{conn: conn, private: %Private{id: id} = private} do
      conn = put(conn, ~p"/api/private/#{private}", private: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/private/#{id}")

      assert %{
               "id" => ^id,
               "from" => "some updated from",
               "message" => "some updated message",
               "to" => "some updated to"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, private: private} do
      conn = put(conn, ~p"/api/private/#{private}", private: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete private" do
    setup [:create_private]

    test "deletes chosen private", %{conn: conn, private: private} do
      conn = delete(conn, ~p"/api/private/#{private}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/private/#{private}")
      end
    end
  end

  defp create_private(_) do
    private = private_fixture()
    %{private: private}
  end
end
