class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    t.string   :card_type
     t.integer  :card_no
     t.string   :card_verification
     t.string   :expiry_date_month
     t.string   :expiry_date_year
     t.string   :first_name
     t.string   :last_name
     t.integer  :amount
     t.string :address
      t.timestamps
    end
  end
end
