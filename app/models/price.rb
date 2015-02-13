class Price < ActiveRecord::Base
  belongs_to :apartment, primary_key: 'aid'

  validates :price_usd, presence: true
  validates :price_byr, presence: true
  validates_presence_of :apartment


end
