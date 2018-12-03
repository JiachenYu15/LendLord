class DeleteUserFromItem < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :user, index: true
  end
end
