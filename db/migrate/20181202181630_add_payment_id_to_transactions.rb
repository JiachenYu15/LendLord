class AddPaymentIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :payment_id, :string
  end
end
