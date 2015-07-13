class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :price
      t.datetime :start_date
      t.datetime :end_date
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :prices, :products
  end
end
