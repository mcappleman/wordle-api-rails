class AddWordleRefToBoards < ActiveRecord::Migration[8.0]
  def change
    add_reference :boards, :wordle, null: false, foreign_key: true
  end
end
