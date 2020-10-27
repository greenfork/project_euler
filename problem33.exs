defmodule DigitCancellingFractions do
  def run do
    {numerator, denominator} =
      Enum.reduce(fractions(), {1, 1}, fn {a, b, _, _}, {n, d} ->
        {n * a, d * b}
      end)
    gcd = gcd(numerator, denominator)
    div(denominator, gcd)
  end

  def fractions do
    for n <- 10..98,
        k <- (n + 1)..99,
        rem(n, 10) != 0 && rem(k, 10) != 0,
        d = gcd(n, k),
        d > 1,
        dn = digits(n),
        dk = digits(k),
        {a, b} <- intersection(dn, dk),
        a != 0,
        nr = div(n, d),
        kr = div(k, d),
        dab = gcd(a, b),
        ar = div(a, dab),
        br = div(b, dab),
        nr == ar && kr == br do
      {n, k, a, b}
    end
  end

  def gcd(a, b) when b == 0, do: a
  def gcd(a, b) when b > a, do: gcd(b, a)
  def gcd(a, b), do: gcd(b, Integer.mod(a, b))

  def digits(n) when is_integer(n), do: do_digits(n, [])
  defp do_digits(n, acc) when n < 10, do: [n | acc]
  defp do_digits(n, acc), do: do_digits(div(n, 10), [rem(n, 10) | acc])

  def intersection([a, b], [c, d]) do
    me =
      cond do
        b == 0 -> {0, 1}
        a == c && b < d -> {b, d}
        a == d && b < c -> {b, c}
        true -> {0, 1}
      end

    mi =
      cond do
        a == 0 -> {0, 1}
        b == c && a < d -> {a, d}
        b == d && a < c -> {a, c}
        true -> {0, 1}
      end

    [me, mi]
  end
end

IO.inspect(DigitCancellingFractions.run())

# 49/98
