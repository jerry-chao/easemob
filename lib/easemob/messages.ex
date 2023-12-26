defmodule Easemob.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Easemob.Repo

  alias Easemob.Messages.Private

  @doc """
  Returns the list of private.

  ## Examples

      iex> list_private()
      [%Private{}, ...]

  """
  def list_private do
    Repo.all(Private)
  end

  @doc """
  Gets a single private.

  Raises `Ecto.NoResultsError` if the Private does not exist.

  ## Examples

      iex> get_private!(123)
      %Private{}

      iex> get_private!(456)
      ** (Ecto.NoResultsError)

  """
  def get_private!(id), do: Repo.get!(Private, id)

  @doc """
  Creates a private.

  ## Examples

      iex> create_private(%{field: value})
      {:ok, %Private{}}

      iex> create_private(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_private(attrs \\ %{}) do
    %Private{}
    |> Private.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a private.

  ## Examples

      iex> update_private(private, %{field: new_value})
      {:ok, %Private{}}

      iex> update_private(private, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_private(%Private{} = private, attrs) do
    private
    |> Private.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a private.

  ## Examples

      iex> delete_private(private)
      {:ok, %Private{}}

      iex> delete_private(private)
      {:error, %Ecto.Changeset{}}

  """
  def delete_private(%Private{} = private) do
    Repo.delete(private)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking private changes.

  ## Examples

      iex> change_private(private)
      %Ecto.Changeset{data: %Private{}}

  """
  def change_private(%Private{} = private, attrs \\ %{}) do
    Private.changeset(private, attrs)
  end

  def send(message) do
    [bodies] = message["payload"]["bodies"]
    [dc|_] = message["to"] |> String.split("_")
    dc = String.to_atom(dc)

    data = %{
      from: message["from"],
      to: message["to"],
      type: bodies["type"],
      body: %{
        msg: bodies["msg"]
      }
    }

    opts = Application.get_env(:easemob, dc)
    IO.puts("send dc #{dc}, data #{inspect(data)}, applicatin #{inspect(opts)}")

    token = app_token(dc)

    request =
      Finch.build(
        :post,
        "#{opts.base_url}/#{opts.org_name}/#{opts.app_name}/messages/users",
        [
          {"Content-Type", "application/json"},
          {"Accept", "application/json"},
          {"Authorization", "Bearer #{token}"}
        ],
        Jason.encode!(data)
      )

    response = Finch.request(request, Easemob.Finch)
    IO.puts("response #{inspect(response)}")
  end

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
