class ChangeIndexOnApartmentsApartType < ActiveRecord::Migration
  def change
    remove_index :apartments, :apart_type
    add_index :apartments, :apart_type, order: {apart_type: :asc}
  end
end
