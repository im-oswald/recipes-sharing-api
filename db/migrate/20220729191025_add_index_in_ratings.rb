class AddIndexInRatings < ActiveRecord::Migration[7.0]
  def change
    add_index :ratings, [:user_id, :recipe_id], unique: true
  end
end
