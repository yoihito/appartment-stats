class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.belongs_to :country
      t.string :name
      t.timestamps null: false
    end
  end
end
