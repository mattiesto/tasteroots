class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :city_id
      t.integer :preference_id

      t.timestamps

    end
  end
end
