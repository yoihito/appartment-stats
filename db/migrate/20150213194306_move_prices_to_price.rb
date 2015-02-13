class MovePricesToPrice < ActiveRecord::Migration
  class Apartment < ActiveRecord::Base
    has_many :prices, primary_key: 'aid'
  end

  class Price < ActiveRecord::Base
    belongs_to :apartment, primary_key: 'aid'
  end

  def up
    Apartment.find_each do |x|
      price = Price.new
      price.apartment_id = x.aid
      price.price_usd = x.price_usd
      price.price_byr = x.price_byr
      price.created_at = x.created_at
      unless price.save
        raise ActiveRecord::RecordInvalid
      end
    end
    remove_column :apartments, :price_usd
    remove_column :apartments, :price_byr
  end

  def down
    add_column :apartments, :price_usd, :integer, null: false
    add_column :apartments, :price_byr, :integer, null: false
  end
end
