defmodule EasemobWeb.PrivateController do
  use EasemobWeb, :controller

  alias Easemob.Messages
  alias Easemob.Messages.Private

  action_fallback EasemobWeb.FallbackController

  def index(conn, _params) do
    private = Messages.list_private()
    render(conn, :index, private: private)
  end

  def create(conn, %{"private" => private_params}) do
    with {:ok, %Private{} = private} <- Messages.create_private(private_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/private/#{private}")
      |> render(:show, private: private)
    end
  end

  def show(conn, %{"id" => id}) do
    private = Messages.get_private!(id)
    render(conn, :show, private: private)
  end

  def update(conn, %{"id" => id, "private" => private_params}) do
    private = Messages.get_private!(id)

    with {:ok, %Private{} = private} <- Messages.update_private(private, private_params) do
      render(conn, :show, private: private)
    end
  end

  def delete(conn, %{"id" => id}) do
    private = Messages.get_private!(id)

    with {:ok, %Private{}} <- Messages.delete_private(private) do
      send_resp(conn, :no_content, "")
    end
  end
end
