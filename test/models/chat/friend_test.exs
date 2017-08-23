defmodule ChattyApi.Chat.FriendTest do
  use ChattyApi.ModelCase

  alias ChattyApi.Chat.Friend

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Friend.changeset(%Friend{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Friend.changeset(%Friend{}, @invalid_attrs)
    refute changeset.valid?
  end
end
