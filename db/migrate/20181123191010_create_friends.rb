class CreateFriends < ActiveRecord::Migration[5.2]

  def change

    create_table :friends do |t|

      t.references :user_from, foreign_key: {to_table: :users}
      t.references :user_to, foreign_key: {to_table: :users}
      t.boolean :has_accepted

      t.timestamps

    end

  end

end
