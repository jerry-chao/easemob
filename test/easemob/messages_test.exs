defmodule Easemob.MessagesTest do
  use Easemob.DataCase

  alias Easemob.Messages

  describe "private" do
    alias Easemob.Messages.Private

    import Easemob.MessagesFixtures

    @invalid_attrs %{from: nil, message: nil, to: nil}

    test "list_private/0 returns all private" do
      private = private_fixture()
      assert Messages.list_private() == [private]
    end

    test "get_private!/1 returns the private with given id" do
      private = private_fixture()
      assert Messages.get_private!(private.id) == private
    end

    test "create_private/1 with valid data creates a private" do
      valid_attrs = %{from: "some from", message: "some message", to: "some to"}

      assert {:ok, %Private{} = private} = Messages.create_private(valid_attrs)
      assert private.from == "some from"
      assert private.message == "some message"
      assert private.to == "some to"
    end

    test "create_private/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_private(@invalid_attrs)
    end

    test "update_private/2 with valid data updates the private" do
      private = private_fixture()
      update_attrs = %{from: "some updated from", message: "some updated message", to: "some updated to"}

      assert {:ok, %Private{} = private} = Messages.update_private(private, update_attrs)
      assert private.from == "some updated from"
      assert private.message == "some updated message"
      assert private.to == "some updated to"
    end

    test "update_private/2 with invalid data returns error changeset" do
      private = private_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_private(private, @invalid_attrs)
      assert private == Messages.get_private!(private.id)
    end

    test "delete_private/1 deletes the private" do
      private = private_fixture()
      assert {:ok, %Private{}} = Messages.delete_private(private)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_private!(private.id) end
    end

    test "change_private/1 returns a private changeset" do
      private = private_fixture()
      assert %Ecto.Changeset{} = Messages.change_private(private)
    end
  end
end
