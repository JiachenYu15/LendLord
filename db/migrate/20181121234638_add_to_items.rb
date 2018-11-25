class AddToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user, index: true
    add_column :items, :is_deleted, :boolean
  end
end
