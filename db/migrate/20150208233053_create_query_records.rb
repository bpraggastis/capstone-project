class CreateQueryRecords < ActiveRecord::Migration
  def change
    create_table :query_records do |t|
      t.string :disease
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.integer :user_id

      t.timestamps
    end
  end
end
