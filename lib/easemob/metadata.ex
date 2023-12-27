defmodule Easemob.Metadata do
  alias Easemob.Hx

  def get_meta(params) do
    dc = Map.fetch!(params, "dc") |> String.to_atom()
    opts = Application.get_env(:easemob, dc)
    IO.puts("request metadata dc #{dc}, applicatin #{inspect(opts)}, userid #{params["userid"]}")

    token = Hx.app_token(dc)

    request =
      Finch.build(
        :get,
        "#{opts.base_url}/#{opts.org_name}/#{opts.app_name}/metadata/user/#{params["userid"]}",
        [
          {"Content-Type", "application/json"},
          {"Accept", "application/json"},
          {"Authorization", "Bearer #{token}"}
        ]
      )

    {:ok, response} = Finch.request(request, Easemob.Finch)
    IO.puts("response #{inspect(response)}")

    case Jason.decode(response.body) do
      {:ok, response_data} ->
        response_data

      {:error, _error} ->
        {:error, :retry}
    end
  end

  def update_meta(params) do
    dc = Map.fetch!(params, "dc") |> String.to_atom()
    opts = Application.get_env(:easemob, dc)
    IO.puts("request metadata dc #{dc}, applicatin #{inspect(opts)}, userid #{inspect(params)}")

    token = Hx.app_token(dc)

    data = %{"avatarurl" => "https://www.easemob.com/avatar.png", "nick" => "北京Tom"}
    urlencoded_body = URI.encode_query(data)

    request =
      Finch.build(
        :put,
        "#{opts.base_url}/#{opts.org_name}/#{opts.app_name}/metadata/user/#{params["userid"]}",
        [
          {"Content-Type", "application/x-www-form-urlencoded"},
          {"Accept", "application/json"},
          {"Authorization", "Bearer #{token}"}
        ],
        urlencoded_body
      )

    {:ok, response} = Finch.request(request, Easemob.Finch)
    IO.puts("update metadata response #{inspect(response)}")

    case Jason.decode(response.body) do
      {:ok, response_data} ->
        response_data

      {:error, _error} ->
        {:error, :retry}
    end
  end
end
