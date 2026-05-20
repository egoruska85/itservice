class CreateCompanydetails < ActiveRecord::Migration[7.0]
  def change
    create_table :companydetails do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name_organization
      t.string :inn
      t.string :kpp
      t.string :current_account
      t.string :recipient_bank_name
      t.string :bik
      t.string :correspondent_account_number
      t.text :additionally

      t.timestamps
    end
  end
end
