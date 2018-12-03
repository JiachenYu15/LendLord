class CreateNotifications < ActiveRecord::Migration[5.2]

  def change

    create_table :notifications do |t|

      t.references :user_to, foreign_key: {to_table: :users}
      t.string :message
      t.boolean :has_seen

      t.timestamps

    end

  end

end
