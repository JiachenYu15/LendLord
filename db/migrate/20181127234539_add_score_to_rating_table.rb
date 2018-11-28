class AddScoreToRatingTable < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :score, :integer
  end
end
