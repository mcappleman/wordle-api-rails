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

    guess.each_char.with_index do |char, index|
      color = "gray"
      if self.answer.word.upcase.include?(char)
        # Need to add validation for the number of each characters present in the answer as well
        if self.answer.word.upcase[index] == char
          color = "green"
        else
          color = "yellow"
        end
      end

      cell = board_row.board_cells.create(char: char, color: color)
      cell.save
    end
  end
end
