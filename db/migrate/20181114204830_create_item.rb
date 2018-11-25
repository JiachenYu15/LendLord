class CreateItem < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :deposit, :scale => 2, :precision => 10
      t.boolean :is_available

      t.timestamps
    end
  end
end
