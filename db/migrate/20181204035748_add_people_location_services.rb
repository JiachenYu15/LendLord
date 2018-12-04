class AddPeopleLocationServices < ActiveRecord::Migration[5.2]
    def change

        add_column :people, :lat, :float
        add_column :people, :lon, :float

    end
end
