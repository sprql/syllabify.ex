defmodule Syllabify do
  @moduledoc """
  Split Russian words into syllables
  """

  @doc """
  Split word into syllables

  ## Examples

      iex> Syllabify.syllabify("Вдохновение")
      ["Вдо", "хно", "ве", "ни", "е"]

  """
  def syllabify(word) do
    letters =
      word
      |> String.graphemes()
      |> Enum.reverse()

    total = Enum.reduce(letters, 0, fn l, total -> if vowel?(l), do: total + 1, else: total end)

    letters
    |> traverse([], [], false, "", total)
    |> Enum.map(&Enum.join/1)
  end

  @vowels ~w(а е ё и о у ы э ю я А Е Ё И О У Ы Э Ю Я)
  @voiced ~w(м р л н М Р Л Н)
  @consonant ~w(б в г д ж з к п с т ф х ц ч ш щ Б В Г Д Ж З К П С Т Ф Х Ц Ч Ш Щ)

  defp vowel?(letter), do: Enum.member?(@vowels, letter)
  defp voiced?(letter), do: Enum.member?(@voiced, letter)

  defp non_letter?(letter),
    do: !vowel?(letter) && !voiced?(letter) && !Enum.member?(@consonant, letter)

  defp traverse([], syllables, syllable, _, _, _), do: [syllable | syllables]

  defp traverse([letter | letters], syllables, syllable, voweled, prev_letter, total) do
    cond do
      voweled && vowel?(letter) ->
        # check if this is a last syllable
        voweled = length(syllables) < total - 2
        traverse(letters, [syllable | syllables], [letter], voweled, letter, total)

      voweled && non_letter?(letter) ->
        traverse(letters, [syllable | syllables], [letter], false, letter, total)

      voweled && letter == prev_letter ->
        syllable = [letter | syllable]
        traverse(letters, [syllable | syllables], [], false, letter, total)

      voweled && voiced?(letter) && !vowel?(prev_letter) ->
        traverse(letters, [syllable | syllables], [letter], false, letter, total)

      true ->
        traverse(
          letters,
          syllables,
          [letter | syllable],
          voweled || vowel?(letter),
          letter,
          total
        )
    end
  end
end
