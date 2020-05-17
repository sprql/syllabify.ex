# Syllabify

Split Russian words into syllables (фонетическое деление слова на слоги)

## Installation

Add `syllabify` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:syllabify, "~> 0.1.0"}
  ]
end
```

### Usage

```elixir
iex> Syllabify.syllabify("Вдохновение")
["Вдо", "хно", "ве", "ни", "е"]
```

Documentation can be found at [https://hexdocs.pm/syllabify](https://hexdocs.pm/syllabify).
