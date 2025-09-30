class AddColumnToAbouts < ActiveRecord::Migration[7.0]
  def change
    add_column :abouts, :phone, :string
    add_column :abouts, :telegram, :string
    add_column :abouts, :address, :string
    add_column :abouts, :whatsapp, :string
    add_column :abouts, :email, :string
  end
end
