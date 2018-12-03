class DropUserTable < ActiveRecord::Migration[5.2]

    def change

        remove_foreign_key :blocks, column: "block_to_id"
        remove_foreign_key :blocks, column: "block_from_id"
        remove_foreign_key :friends, column: "user_to_id"
        remove_foreign_key :friends, column: "user_from_id"
        remove_foreign_key :notifications, :users
        drop_table :users

    end
end
