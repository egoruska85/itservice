class CreateCarousels < ActiveRecord::Migration[7.0]
  def change
    create_table :carousels do |t|
      t.string :title
      t.string :text
      t.string :link

      t.timestamps
    end
  end
end
