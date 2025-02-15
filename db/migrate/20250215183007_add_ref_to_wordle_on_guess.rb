class AddRefToWordleOnGuess < ActiveRecord::Migration[8.0]
  def change
    add_reference :guesses, :wordle, null: false, foreign_key: true
  end
end
