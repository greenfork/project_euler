defmodule DoubleBasePalindromes do
  @limit 1_000_000

  def run, do: Enum.sum(numbers())

  def numbers do
    for n <- :lists.seq(1, @limit, 2), palindrome?(n), do: n
  end

  def palindrome?(n) do
    base10 = inspect(n)
    base2 = String.slice(inspect(n, base: :binary), 2..-1)
    base10 == String.reverse(base10) && base2 == String.reverse(base2)
  end
end

# 585 = 1001001001 - palindrome in base 10 and base 2 representation
