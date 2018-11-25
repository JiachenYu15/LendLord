class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|

      t.timestamps
      t.integer :rater
      t.integer :ratee
      t.integer :transaction_id
    end
  end
end
