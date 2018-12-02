class CreateBlocks < ActiveRecord::Migration[5.2]

  def change

    create_table :blocks do |t|

      t.references :block_from, foreign_key: {to_table: :users}
      t.references :block_to, foreign_key: {to_table: :users}

      t.timestamps

    end

  end

end
