defmodule Mix.Tasks.CreateAdmin do
  use Mix.Task
  import Mix.Ecto
  import Ecto.Query
  alias FirestormWeb.Forums
  alias FirestormWeb.Forums.{User, Role}
  alias FirestormWeb.Repo

  @shortdoc "Create an admin"
  def run([username, email, name, password]) do
    ensure_started(Repo, [])

    admin_role = Role |> where(name: "admin") |> Repo.one
    {:ok, user} = %User{}
    |> User.registration_changeset(%{
      username: username,
      email: email,
      name: name,
      api_token: UUID.uuid4(),
      password: password
    })
    |> Repo.insert

    Forums.add_role(user, admin_role)

    IO.inspect(user)
  end
end
