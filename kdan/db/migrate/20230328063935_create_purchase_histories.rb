class CreatePurchaseHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_histories do |t|
      t.string :pharmacy_name
      t.string :mask_name
      t.float :transaction_amount
      t.string :transaction_date
      t.references :user, null: false, foreign_key: true
      t.references :mask, null: false, foreign_key: true
      t.references :pharmacy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
