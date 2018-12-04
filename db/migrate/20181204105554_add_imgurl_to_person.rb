class AddImgurlToPerson < ActiveRecord::Migration[5.2]

    def change

        add_column :people, :imgurl, :string

    end

end
