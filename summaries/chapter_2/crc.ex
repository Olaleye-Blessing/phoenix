# CRC pattern -- Constructors, Reducers, Converters

# Constructors create a term of the core type from convenient inputs.
# Reducers transform a term of the core type to another term of that type.
# Converters convert the core type to some other type

defmodule Number do
  # the constructor
  def new(string), do: Integer.parse(string) |> elem(0) # integer.parse returns a tupule of the form {integer, remainder}

  # reducer
  def add(number, addend), do: number + addend

  # converter
  def to_string(number), do Integer.to_string(number)
end

# usage
list = [1, 2, 3, 4]
total = Number.new("0")
reducer = &Number.add(&2, &1)
converter = &Number.to_string/1
reduced_val = Enum.reduce(list, total, reducer) |> converter.()
IO.puts reduced_val

# it looks like the below when using pipeline
# [first, second, third, fourth] = list
val = "0" \
 |> Number.new \
 |> Number.add(first) \
 |> Number.add(second) \
 |> Number.add(third) \
 |> Number.add(fourth) \
 |> Number.to_string

IO.puts val
