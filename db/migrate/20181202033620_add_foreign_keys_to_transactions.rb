class AddForeignKeysToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :item, index: true
    add_reference :transactions, :user, index: true
  end
end
