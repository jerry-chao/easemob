defmodule EasemobWeb.MetadataController do
  use EasemobWeb, :controller

  alias Easemob.Metadata

  action_fallback EasemobWeb.FallbackController

  def get(conn, params) do
    metadata = Metadata.get_meta(params)
    json(conn, metadata)
  end

  def update(conn, params) do
    response = Metadata.update_meta(params)
    json(conn, response)
  end

end
