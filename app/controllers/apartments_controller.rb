class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.group(:apart_type).order(:apart_type).median(:price_usd)
    puts @apartments.inspect

    @apartments_by_day = Apartment
      .group('date_trunc(\'day\',created_at)','apart_type')
      .order('date_trunc(\'day\',created_at)')
      .median(:price_usd)
      .reduce({}) { |res, apartment|
        res[apartment[0][1]] = res[apartment[0][1]].nil? ? {apartment[0][0] => apartment[1]} : res[apartment[0][1]][apartment[0][0]] = apartment[1]
        res
      }.flat_map {|z,a| [name: z, data: a]}

    puts @apartments_by_day.inspect
  end
end
