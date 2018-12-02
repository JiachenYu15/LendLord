class RemoveAllColumnFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :item_id, :integer
    remove_column :transactions, :lend_to_user_id, :integer
    remove_column :transactions, :start_date, :date
    remove_column :transactions, :due_date, :date
    remove_column :transactions, :deposit, :decimal
    remove_column :transactions, :status, :string
  end
end
