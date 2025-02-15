class AddUserRefToWordle < ActiveRecord::Migration[8.0]
  def change
    add_reference :wordles, :user, null: false, foreign_key: true
  end
end
