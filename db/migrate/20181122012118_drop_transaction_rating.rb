class DropTransactionRating < ActiveRecord::Migration[5.2]
  def change
    drop_table :transaction_ratings
  end
end
