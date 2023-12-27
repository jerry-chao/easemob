defmodule Easemob.Hx do
  def hx_token_key(dc) do
    String.to_atom("#{dc}_token")
  end

  def app_token(dc) do
    case Application.get_env(:easemob, hx_token_key(dc)) do
      nil ->
        opts = Application.get_env(:easemob, dc)
        hxtoken = request_token(opts)
        Application.put_env(:easemob, hx_token_key(dc), hxtoken)
        hxtoken

      hxtoken ->
        hxtoken
    end
  end

  def refresh_token(dc) do
    Application.delete_env(:easemob, hx_token_key(dc))
    app_token(dc)
  end

  def request_token(opts) do
    credential = %{
      grant_type: "client_credentials",
      client_id: opts.client_id,
      client_secret: opts.client_secret,
      ttl: 86400
    }

    {:ok, data} = Jason.encode(credential)

    request =
      Finch.build(
        :post,
        "#{opts.base_url}/#{opts.org_name}/#{opts.app_name}/token",
        [{"Content-Type", "application/json"}, {"Accept", "application/json"}],
        data
      )

    {:ok, response} = Finch.request(request, Easemob.Finch)

    case Jason.decode(response.body) do
      {:ok, response_data} ->
        Map.get(response_data, "access_token")

      {:error, _error} ->
        {:error, :retry}
    end
  end
end
