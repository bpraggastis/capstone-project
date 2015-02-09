class ChangeCommentsAuthorAndQueryColumnNames < ActiveRecord::Migration
  def change
    rename_column :comments, :author, :user_id
    rename_column :comments, :query, :query_record_id
  end
end
