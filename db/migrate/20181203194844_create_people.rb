class CreatePeople < ActiveRecord::Migration[5.2]

    def change
        create_table :people do |t|

            t.string :username
            t.string :firstname
            t.string :lastname
            t.string :telephone
            t.string :country
            t.string :city
            t.string :address

            t.timestamps
        end
    end
end
