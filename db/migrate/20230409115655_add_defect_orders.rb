class AddDefectOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :defect, :text
  end
end
