defmodule Easemob.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Easemob.Messages` context.
  """

  @doc """
  Generate a private.
  """
  def private_fixture(attrs \\ %{}) do
    {:ok, private} =
      attrs
      |> Enum.into(%{
        from: "some from",
        message: "some message",
        to: "some to"
      })
      |> Easemob.Messages.create_private()

    private
  end
end
