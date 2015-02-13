class Apartment < ActiveRecord::Base
  has_many :prices, primary_key: 'aid'
end
