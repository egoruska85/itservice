class CreateMailparametrs < ActiveRecord::Migration[7.0]
  def change
    create_table :mailparametrs do |t|
      t.string :address
      t.integer :port
      t.string :domain
      t.string :username
      t.string :password
      t.string :authentication
      t.boolean :enable_starttls_auto

      t.timestamps
    end
  end
end
