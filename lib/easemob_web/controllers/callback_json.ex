defmodule EasemobWeb.CallbackJSON do

  @doc """
  Renders a list of postcallback.
  """
  def index(%{postcallback: _postcallback}) do
    %{data: []}
  end

  @doc """
  Renders a single callback.
  """
  def show(%{callback: _callback}) do
    %{data: %{}}
  end
end
