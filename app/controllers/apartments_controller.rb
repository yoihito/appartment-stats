class ApartmentsController < ApplicationController
  def index
    @apartments_price_average = Apartment.joins(:prices).group(:apart_type).order(:apart_type).median(:price_usd)
    @apartments_price_by_day = Apartment.joins(:prices)
      .group('date_trunc(\'day\',prices.created_at)','apart_type')
      .order('apart_type')
      .average('prices.price_usd')
      .reduce({}) { |res, apartment|
        res[apartment[0][1]] = {} if res[apartment[0][1]].nil?
        res[apartment[0][1]].store(apartment[0][0], apartment[1])
        res
      }
      .flat_map {|z,a| [name: z, data: a]}
    @apartments_number_by_type = Apartment.group(:apart_type).order('apart_type').count
    total = {}
    @apartments_number_by_day = Apartment.joins(:prices)
      .group('date_trunc(\'day\',prices.created_at)','apart_type')
      .order('apart_type')
      .count
      .reduce({}) { |res, apartment|
        res[apartment[0][1]] = {} if res[apartment[0][1]].nil?
        res[apartment[0][1]].store(apartment[0][0], apartment[1])
        total[apartment[0][0]] = 0 if total[apartment[0][0]].nil?
        total[apartment[0][0]] += apartment[1]
        res
      }
      .flat_map {|z,a| [name: z, data: a]}
      .push(name: 'total', data: total)


  end
end
