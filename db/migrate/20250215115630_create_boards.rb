class CreateBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :boards do |t|
      t.string :status
      t.string :answer

      t.timestamps
    end
  end
end
