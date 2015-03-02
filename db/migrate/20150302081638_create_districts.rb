class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.belongs_to :city
      t.string :name
      t.json :geojson
      t.timestamps null: false
    end
  end
end
