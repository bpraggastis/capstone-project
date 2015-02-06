class CreateEventPlaces < ActiveRecord::Migration
  def change
    create_table :event_places do |t|
      t.integer :place_id
      t.integer :event_id

      t.timestamps
    end
  end
end
