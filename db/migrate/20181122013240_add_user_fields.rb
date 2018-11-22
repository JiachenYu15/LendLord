class AddUserFields < ActiveRecord::Migration[5.2]

	def change

		add_column :users, :fname, :text
		add_column :users, :lname, :text
		add_column :users, :address, :text
		add_column :users, :home_number, :text
		add_column :users, :cell_number, :text

	end
end
