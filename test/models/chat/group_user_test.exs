defmodule ChattyApi.Chat.GroupUserTest do
  use ChattyApi.ModelCase

  alias ChattyApi.Chat.GroupUser

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GroupUser.changeset(%GroupUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GroupUser.changeset(%GroupUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
