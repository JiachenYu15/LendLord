class RecreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :start_date
      t.date :due_date
      t.decimal :deposit, precision: 10, scale: 2
      t.string :status
    end
  end
end
