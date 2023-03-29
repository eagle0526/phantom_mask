class CreateOpeningTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :opening_times do |t|
      t.string :Mon
      t.string :Tue
      t.string :Wed
      t.string :Thur
      t.string :Fri
      t.string :Sat
      t.string :Sun
      t.references :pharmacy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
