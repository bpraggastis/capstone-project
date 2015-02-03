class SetDefaultsForUserModel < ActiveRecord::Migration
  def change
    change_column_default :users, :tier, 'unconfirmed'
  end
end
