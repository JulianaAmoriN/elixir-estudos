defmodule AnFactorial do

  fact_gen = fn me ->
    fn
      0 -> 1
      n when n > 0 -> n * me.(me).(n - 1)
    end
  end

  factorial = fact_gen.(fact_gen)
  IO.puts(factorial.(5))

end
