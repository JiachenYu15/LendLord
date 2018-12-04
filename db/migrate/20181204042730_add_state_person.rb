class AddStatePerson < ActiveRecord::Migration[5.2]

    def change

        add_column :people, :state, :string

    end
end
