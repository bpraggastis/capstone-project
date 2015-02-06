class CreateGeoPlaces < ActiveRecord::Migration
  def change
    create_table :geo_places do |t|
      t.integer :place_id
      t.integer :geo_id

      t.timestamps
    end
  end
end
