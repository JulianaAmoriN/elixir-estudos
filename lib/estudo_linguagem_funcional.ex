defmodule EstudoLinguagemFuncional do
  # def meu_ambiente do
  #   case Mix.env() do
  #     :prod -> "Ambiente de Produção"
  #     :dev -> "Ambiente de Desenvolvimento"
  #     :test -> "Ambiente de Testes"
  #   end

  def intit do
    App.CLI.Main.start_app()
  end
end
