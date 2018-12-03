class PersonUserRelationship < ActiveRecord::Migration[5.2]
  
    def change

        add_reference :people, :user, foreign_key: true, index: true

    end
end
