class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.string :phone
      t.date :date
      t.time :time
      t.boolean :verificate
      t.boolean :done

      t.timestamps
    end
  end
end
