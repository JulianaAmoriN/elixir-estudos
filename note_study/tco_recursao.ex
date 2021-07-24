defmodule TCFactorial do
  def of(n), do: factorial_of(n, 1)

  defp factorial_of(0, acumulador), do: acumulador
  defp factorial_of(n, acumulador) when n > 0, do: factorial_of( n - 1, n * acumulador)
end
