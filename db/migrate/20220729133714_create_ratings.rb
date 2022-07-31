class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :user
      t.belongs_to :recipe
      t.integer :rated_as

      t.timestamps
    end
  end
end
