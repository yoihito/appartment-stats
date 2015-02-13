class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.belongs_to :apartment
      t.integer :price_usd, null: false
      t.integer :price_byr, null: false
      t.timestamp :created_at, null: false
    end
  end
end
