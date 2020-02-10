class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column  :users,  :mail_check,  :boolean, default: false
  end
end
