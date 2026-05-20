class AddFlagsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :private, :boolean, default: false
    add_column :users, :organization, :boolean, default: false
  end
end
