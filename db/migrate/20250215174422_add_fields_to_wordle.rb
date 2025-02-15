class AddFieldsToWordle < ActiveRecord::Migration[8.0]
  def change
    add_column :wordles, :max_guesses, :integer
    add_column :wordles, :num_of_boards, :integer
  end
end
