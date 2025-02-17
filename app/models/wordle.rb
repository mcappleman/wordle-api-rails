class Wordle < ApplicationRecord
  belongs_to :user
  has_many :boards
  has_many :guesses

  validates :max_guesses, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :num_of_boards, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Add any additional logic or methods here
  def create_boards 
    # Create a board for number of boards that were requested.
    answers = []
    self.num_of_boards.times do
      # Create a board with a random answer from the Answer model.
      answer = Answer.random_word
      while(answers.include?(answer.id))
        answer = Answer.random_word
      end
      answers << answer.id
      self.boards.create(answer_id: answer.id, status: "active", wordle_id: self.id)
    end
  end

  def check_guess(guess)
    # Check if the guess is correct.
    num_of_guesses = self.guesses.length
    boards = self.boards.where(status: "active")
    boards.each do |board|
      if board.answer.word == guess
        # If the guess is correct, update the board status to "solved".
        board.update(status: "solved")
      elsif num_of_guesses >= self.max_guesses
        # If the guess is incorrect, update the board status to "failed".
        board.update(status: "failed")
      end
    end
  end

  def game_over?
    self.boards.each do |board|
      board.board_won?
    end
    # Check if the game is over.
    boards = self.boards.where(status: "active")
    if boards.length == 0
      self.update(status: "completed")
    elsif self.guesses.length >= self.max_guesses
      self.update(status: "failed")
    end
    if self.status == "completed" || self.status == "failed"
      return true
    end
    false
  end
end
