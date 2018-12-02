class RemoveBorrowFromUserIdFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :borrow_from_user_id, :integer
  end
end
