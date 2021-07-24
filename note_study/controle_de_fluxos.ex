# x = 7

# if x == 10, do: "e igual", else: "nao e igual"

# unless x == 10 do
#   "não é igual"
#  else
#   "igual"
# end

#  cond do
#   x + 4 == 12  -> "12"
#   x + 1 == 8  -> "8"
#   x + 4 == 11  -> "11"
#  end

# case :tobias do
#   :monoel -> "manoel"
#   :junior -> "junior"
#   :tobias -> "tobias"
# end

# case :tobias do
#   :monoel -> "manoel"
#   10 -> "10"
#   _ -> "passa tudo"
# end

# case {1,2,3} do
#    {1,x,3} when x > 0 -> "vai funcionar porque 2 e maior que 0"
#    _ -> "isso passaria tambem"
#    10 -> "10"
#  end

######################################################################################

#Como funciona Enum.map() + Range
# range = 1..7
# Enum.map(range, fn n -> n * 2 end)
#
# Retorna : [2, 4, 6, 8, 10, 12, 14]
#
#  * com função anonima *
# Enum.map(range, &( &1 * 2 ))
# Retorna : [2, 4, 6, 8, 10, 12, 14]
#
# Enum.map(range, &(&1))
# Retorna : [1, 2, 3, 4, 5, 6, 7]

#Como funciona Enum.take() + Range
#
# range  = 1..9
# Enum.take(range, 3)
# Retorna : [1, 2, 3]
#
# 1..9 |> Enum.take(3)
# Retorna : [1, 2, 3]

#Como funciona Stram.map() + Range
# range = 1..5_000_00
#
#  Enum.map(range, &(&1)) |> Enum.take(10)
#   Retorna : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
#
#  Stream.map(range, &(&1)) |> Enum.take(10)     *carrega apenas os elementos necessários para o Enum.take*
#   Retorna : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

##################################################################################

#Atualizado valores de Maps
#
# abc = %{e: 1, f: 4}
#   Retorna : %{e: 1, f: 4}
#
# abc.f
#   Retorna : 4
#
# %{ abc | f: 5}                      *alterar sem mudar o abc real*
#   Retorna : %{e: 1, f: 5}
#
# abc
#   Retorna : %{e: 1, f: 4}
#
# abc = %{ abc | f: 5}                *modificar abc realmente*
#   Retorna : %{e: 1, f: 5}
#
# abc
#   Retorna : %{e: 1, f: 5}
