class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :number_infected
      t.datetime :duration
      t.datetime :end_date
      t.string :status

      t.timestamps
    end
  end
end
