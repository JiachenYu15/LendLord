class CreateTransactionRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_ratings do |t|
      t.string :username
      t.integer :transaction
      t.boolean :role
      t.datetime :date

      t.timestamps
    end
  end
end
