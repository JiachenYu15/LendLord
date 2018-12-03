class AddPersonToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :person, index: true
  end
end
