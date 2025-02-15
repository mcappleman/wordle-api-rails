class CreateGuesses < ActiveRecord::Migration[8.0]
  def change
    create_table :guesses do |t|
      t.string :word

      t.timestamps
    end
  end
end
