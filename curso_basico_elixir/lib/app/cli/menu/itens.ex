defmodule App.CLI.Menu.Intens do
  alias App.CLI.Menu

  def all, do: [
    %Menu{ label: "Cadastrar um amigo", id: :create},
    %Menu{ label: "Lista de amigos", id: :read},
    %Menu{ label: "Atuliazar um amigo", id: :update},
    %Menu{ label: "Excluir um amigo", id: :delete}
  ]

end
