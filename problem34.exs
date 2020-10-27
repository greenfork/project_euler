defmodule DigitFactorials do
  def run do
    Enum.reduce(numbers(), &+/2)
  end

  def factorials, do: Enum.reduce(0..9, %{}, fn n, m -> Map.put(m, n, factorial(n)) end)

  def numbers do
    factorials = factorials()
    for n <- 11..1_999_999, n == factorial_sum(n, factorials), do: n
  end

  def factorial_sum(n, factorials) do
    Enum.reduce(Integer.digits(n), 0, fn x, acc -> acc + Map.get(factorials, x) end)
  end

  def factorial(n) when n < 2, do: 1
  def factorial(n), do: do_factorial(n, 1)
  defp do_factorial(n, acc) when n == 1, do: acc
  defp do_factorial(n, acc), do: do_factorial(n - 1, n * acc)
end

IO.inspect(DigitFactorials.run())

# 1! + 4! + 5! = 1 + 24 + 120 = 145
