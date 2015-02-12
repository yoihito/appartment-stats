class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.group(:apart_type).average(:price_usd).sort(:apart_type)
  end
end
