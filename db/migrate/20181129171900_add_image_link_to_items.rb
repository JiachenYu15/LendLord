class AddImageLinkToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :image_link, :string
  end
end
