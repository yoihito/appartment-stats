class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :prices, :apartment_id
    add_index :prices, :created_at

    add_index :apartments, :aid
    add_index :apartments, :apart_type
  end
end
