class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author
      t.integer :query

      t.timestamps
    end
  end
end
