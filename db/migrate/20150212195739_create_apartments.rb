class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.integer :aid
      t.string :url
      t.string :apart_type
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :price_usd
      t.integer :price_byr
      t.timestamps null: false
    end
  end
end
