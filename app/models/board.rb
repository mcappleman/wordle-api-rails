class Board < ApplicationRecord
  belongs_to :wordle
  belongs_to :answer

  def get_color_codes(guesses)
    # Color code the guesses.
    # The color code is based on the number of correct guesses.
    # Green represents a correct guess, yellow represents a correct letter in the wrong position, and red represents an incorrect guess.
    answer = self.answer.word
    color_codes = []
    guesses.each do |guess|
      color_code = []
      answer.each_char.with_index do |char, index|
        if guess.word.include?(char)
          if guess.word[index] == char
            color_code << {char: guess.word[index], color: "green"}
          else
            color_code << {char: guess.word[index], color: "yellow"}
          end
        else
          color_code << {char: guess.word[index], color: "gray"}
        end
      end
      color_codes << color_code
    end
    color_codes
  end

  def to_json
    {
      id: self.id,
      status: self.status,
      answer: self.answer.word,
      codes: self.get_color_codes(self.wordle.guesses)
    }
  end
end
