class CreateGeos < ActiveRecord::Migration
  def change
    create_table :geos do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :gazateer

      t.timestamps
    end
  end
end
