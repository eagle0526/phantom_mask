class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.float :cash_balance

      t.timestamps
    end
  end
end
