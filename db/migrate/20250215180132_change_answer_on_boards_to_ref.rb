class ChangeAnswerOnBoardsToRef < ActiveRecord::Migration[8.0]
  def change
    remove_column :boards, :answer
    add_reference :boards, :answer, null: false, foreign_key: true
  end
end
