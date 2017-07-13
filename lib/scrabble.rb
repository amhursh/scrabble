require 'pry'

class Scrabble

  # > game = Scrabble.new
  # => ...
  # > game.score("hello")
  # => 8
  # > game.score("")
  # => 0
  # > game.score(nil)
  # => 0
  # > game.score_with_multipliers('hello', [1,2,1,1,1])
  # => 9
  # > game.score_with_multipliers('hello', [1,2,1,1,1], 2)
  # => 18
  # > game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)
  # => 58

  def score(word)
    sum_word_values(word)
  end

  def score_with_multipliers(word, letter_multiplier, word_multiplier = 1)
    sum_multiplied_points_list(word, letter_multiplier) * word_multiplier
  end

  def get_point_values_with_letter_multiplier(word, letter_multiplier = [])
    point_values_list = get_point_values_for_each_letter(word)
    letter_multiplier.zip(point_values_list).map do | multiplier, points |
      multiplier * points
    end
  end

  def sum_multiplied_points_list(word, letter_multiplier = [])
    point_values_list = get_point_values_with_letter_multiplier(word, letter_multiplier)
    point_values_list.inject do |sum, points|
      sum + points
    end
  end

  def get_point_values_for_each_letter(word)
    point_values_list = []
    if word.class != String
      point_values_list << 0
    elsif word.empty?
      point_values_list << 0
    else
      word.each_char do |char|
        points = point_values[char.upcase]
        point_values_list << points
      end
    end
    return point_values_list
  end

  def sum_word_values(word)
    points_for_each_letter = get_point_values_with_letter_multiplier(word)
    points_for_each_letter.inject do |sum, points|
      sum + points
    end
  end

  # def double_word_score(word_multiplier, word)
  #   sum_word_values(word) * word_multiplier
  # end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end


end

p scrab = Scrabble.new
p scrab.score("Hello")
p scrab.get_point_values_for_each_letter("Hello")
p scrab.score("Hello")
p scrab.score("")
p scrab.score(0)
p scrab.score_with_multipliers('hello', [1,2,1,1,1])
p scrab.score_with_multipliers('hello', [1,2,1,1,1], 2)
p scrab.score_with_multipliers('hello', [1,2,1,1,1], 3)
