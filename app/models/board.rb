class Board < ApplicationRecord
  belongs_to :wordle
  belongs_to :answer
  has_many :board_rows, dependent: :destroy

  def board_won?
    if self.answer.word == self.wordle.guesses.last.word
      self.status == "solved"
      self.save
      return true
    end
    false
  end

  def add_row(guess)
    if self.status != "active"
      return
    end
    board_row = self.board_rows.create
    board_row.save
    answer_char_count = self.answer.word.upcase.chars.tally
    guess.each_char.with_index do |char, index|
      color = "gray"
      if self.answer.word.upcase[index] == char
        color = "green"
        answer_char_count[char] -= 1
      elsif self.answer.word.upcase.include?(char) && answer_char_count[char] > 0
        answer_char_index = self.answer.word.upcase.index(char)
        if guess[answer_char_index] == char && answer_char_count[char] < 2
          color = "gray"
        else
          color = "yellow"
          answer_char_count[char] -= 1
        end
      end

      cell = board_row.board_cells.create(char: char, color: color)
      cell.save
    end
  end
end
