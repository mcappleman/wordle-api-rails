class Board < ApplicationRecord
  belongs_to :wordle
  belongs_to :answer
  has_many :board_rows

  def board_won?
    # Check if the board has been won.
    if self.answer.word == self.wordle.guesses.last.word
      self.status == "solved"
      self.save
      return true
    end
    false
  end

  def add_row(guess)
    # Add a row to the board.
    if self.status != "active"
      return
    end
    board_row = self.board_rows.create
    board_row.save

    guess.each_char.with_index do |char, index|
      color = "gray"
      if self.answer.word.upcase.include?(char)
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
