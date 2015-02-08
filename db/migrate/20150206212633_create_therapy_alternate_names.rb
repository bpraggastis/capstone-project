class CreateTherapyAlternateNames < ActiveRecord::Migration
  def change
    create_table :therapy_alternate_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
