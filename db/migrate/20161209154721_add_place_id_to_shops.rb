class AddPlaceIdToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :place_id, :string
  end
end
