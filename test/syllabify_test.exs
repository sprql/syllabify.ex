defmodule SyllabifyTest do
  use ExUnit.Case, async: true
  doctest Syllabify

  test "ё" do
    assert Syllabify.syllabify("перепёлка") == ["пе", "ре", "пёл", "ка"]
  end

  test "й" do
    assert Syllabify.syllabify("войлоки") == ["вой", "ло", "ки"]
  end

  test "voiced" do
    assert Syllabify.syllabify("помидорка") == ["по", "ми", "дор", "ка"]
  end

  test "first vowel" do
    assert Syllabify.syllabify("улитка") == ["у", "ли", "тка"]
  end

  test "double consonant in the middle" do
    assert Syllabify.syllabify("каменная") == ["ка", "ме", "нна", "я"]
  end

  test "double consonant in the end" do
    assert Syllabify.syllabify("воспитанность") == ["во", "спи", "та", "нность"]
  end

  test "long word" do
    assert Syllabify.syllabify("заинтересованностью") == [
             "за",
             "ин",
             "те",
             "ре",
             "со",
             "ва",
             "нность",
             "ю"
           ]
  end

  test "dash" do
    assert Syllabify.syllabify("кто-то") == ["кто-", "то"]
  end

  test "non letter" do
    assert Syllabify.syllabify("кто/что") == ["кто/", "что"]
  end

  test "double vowel" do
    assert Syllabify.syllabify("единообразие") == ["е", "ди", "но", "о", "бра", "зи", "е"]
  end

  test "йо" do
    assert Syllabify.syllabify("йогурт") == ["йо", "гурт"]
  end

  test "ь in the start" do
    assert Syllabify.syllabify("рьяный") == ["рья", "ный"]
  end

  test "uppercase" do
    assert Syllabify.syllabify("ВОЙЛОКИ") == ["ВОЙ", "ЛО", "КИ"]
  end
end
