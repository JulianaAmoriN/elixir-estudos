defmodule App.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Precione ENTER para continuar")
    start_menu_choice()
  end

  defp welcome_message do
    Shell.info("==== Aplicação ====")
    Shell.info("  Seja bem-vindo   ")
    Shell.info("===================")
  end

  defp start_menu_choice, do: App.CLI.Menu.Choice.start()
end
