defmodule PandigitalProducts do
  def run do
    one_digit =
      for n <- 2..8,
          k <- 1234..4987,
          p = n * k,
          p < 10_000,
          dk = digits(k),
          !Enum.member?(dk, 0),
          dp = digits(p),
          !Enum.member?(dp, 0),
          Enum.count(Enum.uniq(digits(p) ++ digits(n) ++ digits(k))) == 9 do
        [p, n, k]
      end

    two_digit =
      for n <- 12..80,
          k <- 123..832,
          p = n * k,
          p < 10_000,
          dn = digits(n),
          !Enum.member?(dn, 0),
          dk = digits(k),
          !Enum.member?(dk, 0),
          dp = digits(p),
          !Enum.member?(dp, 0),
          Enum.count(Enum.uniq(digits(p) ++ digits(n) ++ digits(k))) == 9 do
        [p, n, k]
      end

    (one_digit ++ two_digit)
    |> Enum.map(fn [p, n, k] -> p end)
    |> Enum.uniq()
    |> Enum.sum()
  end

  def digits(n) when is_integer(n) do
    do_digits(n, [])
  end

  defp do_digits(n, acc) do
    if n < 10, do: [n | acc], else: do_digits(div(n, 10), [rem(n, 10) | acc])
  end
end

IO.inspect(PandigitalProducts.run())
