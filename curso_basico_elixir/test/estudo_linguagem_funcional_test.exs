defmodule EstudoLinguagemFuncionalTest do
  use ExUnit.Case
  doctest EstudoLinguagemFuncional

  test "greets the world" do
    assert EstudoLinguagemFuncional.hello() == :world
  end
end
