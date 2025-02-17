class AddBoardRowAndBoardCell < ActiveRecord::Migration[8.0]
  def change
    create_table :board_rows do |t|
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end

    create_table :board_cells do |t|
      t.references :board_row, null: false, foreign_key: true

      t.timestamps
    end
    add_column :board_cells, :char, :string, null: false
    add_column :board_cells, :color, :string, null: false
  end
end
