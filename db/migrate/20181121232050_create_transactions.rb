class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :item_id
      t.integer :borrow_from_user_id
      t.integer :lend_to_user_id
      t.date :start_date
      t.date :due_date
      t.decimal :deposit, precision: 8, scale: 2
      t.string :status

      t.timestamps
    end
  end
end
