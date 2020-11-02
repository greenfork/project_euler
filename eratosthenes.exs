defmodule Eratosthenes do
  @prime_limit 1_000_000

  def prime_list(primes) do
    for {p, i} <- Enum.with_index(:array.to_list(primes)), p == true, do: i
  end

  def primes do
    arr =
      :array.new(@prime_limit, {:default, true})
      |> aset(0, false)
      |> aset(1, false)

    do_primes(arr, next_prime(arr, 1))
  end

  defp do_primes(array, prime) when is_nil(prime), do: array

  defp do_primes(array, prime) do
    array = crossout(array, prime)
    do_primes(array, next_prime(array, prime))
  end

  defp crossout(array, prime) do
    if prime * prime < @prime_limit do
      Enum.reduce(:lists.seq(prime * prime, @prime_limit - 1, prime), array, fn p, acc ->
        aset(acc, p, false)
      end)
    else
      array
    end
  end

  def next_prime(array, after_number) do
    Enum.find((after_number + 1)..(@prime_limit - 1), fn x -> aget(array, x) == true end)
  end

  def aset(array, index, value), do: :array.set(index, value, array)
  def aget(array, index), do: :array.get(index, array)
end
