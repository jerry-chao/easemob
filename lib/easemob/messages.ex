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
end
