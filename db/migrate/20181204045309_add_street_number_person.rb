class AddStreetNumberPerson < ActiveRecord::Migration[5.2]

    def change

        add_column :people, :addressno, :integer

    end

end
