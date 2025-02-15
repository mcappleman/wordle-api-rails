class AddAnswersTable < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.string :word

      t.timestamps
    end
  end
end
