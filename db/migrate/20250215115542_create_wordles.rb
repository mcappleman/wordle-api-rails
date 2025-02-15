class CreateWordles < ActiveRecord::Migration[8.0]
  def change
    create_table :wordles do |t|
      t.string :status

      t.timestamps
    end
  end
end
