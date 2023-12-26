defmodule Easemob.Messages.Private do
  use Ecto.Schema
  import Ecto.Changeset

  schema "private" do
    field :from, :string
    field :message, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(private, attrs) do
    private
    |> cast(attrs, [:from, :to, :message])
    |> validate_required([:from, :to, :message])
  end
end
