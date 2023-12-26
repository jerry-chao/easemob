defmodule EasemobWeb.PrivateJSON do
  alias Easemob.Messages.Private

  @doc """
  Renders a list of private.
  """
  def index(%{private: private}) do
    %{data: for(private <- private, do: data(private))}
  end

  @doc """
  Renders a single private.
  """
  def show(%{private: private}) do
    %{data: data(private)}
  end

  defp data(%Private{} = private) do
    %{
      id: private.id,
      from: private.from,
      to: private.to,
      message: private.message
    }
  end
end
