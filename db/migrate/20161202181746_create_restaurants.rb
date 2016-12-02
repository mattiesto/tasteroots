class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :city_id
      t.integer :preference_id

      t.timestamps

    end
  end
end
