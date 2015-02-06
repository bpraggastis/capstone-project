class CreateOutbreaks < ActiveRecord::Migration
  def change
    create_table :outbreaks do |t|
      t.integer :medical_condition_id
      t.integer :event_id

      t.timestamps
    end
  end
end
