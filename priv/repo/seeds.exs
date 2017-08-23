# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ChattyApi.Repo.insert!(%ChattyApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias ChattyApi.Account.User
alias ChattyApi.Chat.Group
alias ChattyApi.Chat.GroupUser
alias ChattyApi.Chat.Message
alias ChattyApi.Chat.Friend
alias ChattyApi.Repo

Repo.insert!(%User{username: "Ryan Swapp", email: "ryan@ryan.com", password: "1234"})
Repo.insert!(%User{username: "Rosie", email: "rosie@mydog.com", password: "1234"})
Repo.insert!(%User{username: "Sam", email: "sam@mydog.com", password: "1234"})

Repo.insert!(%Group{name: "GraphQl Chat"})
Repo.insert!(%Group{name: "My second chat"})
Repo.insert!(%Group{name: "My third chat"})

Repo.insert!(%GroupUser{user_id: 1, group_id: 1})
Repo.insert!(%GroupUser{user_id: 1, group_id: 2})
Repo.insert!(%GroupUser{user_id: 2, group_id: 2})
Repo.insert!(%GroupUser{user_id: 3, group_id: 2})
Repo.insert!(%GroupUser{user_id: 3, group_id: 1})
Repo.insert!(%GroupUser{user_id: 3, group_id: 3})

Repo.insert!(%Friend{user_id: 1, friend_id: 2})
Repo.insert!(%Friend{user_id: 3, friend_id: 2})
Repo.insert!(%Friend{user_id: 3, friend_id: 1})
Repo.insert!(%Friend{user_id: 2, friend_id: 1})

for _ <- 1..15 do
  Repo.insert!(%Message{
    text: Faker.Lorem.sentence(20),
    user_id: [1, 2, 3] |> Enum.take_random(1) |> hd,
    group_id: [1, 2, 3] |> Enum.take_random(1) |> hd
  })
end