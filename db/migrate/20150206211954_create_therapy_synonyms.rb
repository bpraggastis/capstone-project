class CreateTherapySynonyms < ActiveRecord::Migration
  def change
    create_table :therapy_synonyms do |t|
      t.integer :therapy_alternate_name_id
      t.integer :medical_therapy_id

      t.timestamps
    end
  end
end
