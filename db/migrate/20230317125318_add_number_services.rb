class AddNumberServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :number, :string
    add_index :services, :number, unique: true
  end
end
