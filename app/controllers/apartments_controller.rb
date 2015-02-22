class ApartmentsController < ApplicationController
  def index
    @apartments_price_by_day = Apartment.where(apart_type: ['1_room','2_rooms']).joins(:prices)
      .group('date_trunc(\'day\',prices.created_at)','apart_type')
      .order('apart_type')
      .average('prices.price_usd')
      .reduce({}) { |res, apartment|
        res[apartment[0][1]] = {} if res[apartment[0][1]].nil?
        res[apartment[0][1]].store(apartment[0][0], apartment[1])
        res
      }
      .flat_map {|z,a| [name: z, data: a]}

    @apartments_median = Price.joins(:apartment)
      .where('apartments.apart_type in (?)', ['1_room'])
      .where('prices.created_at >= date_trunc(\'day\', date ?)',DateTime.current)
      .group('prices.price_usd')
      .order('prices.price_usd')
      .count

    current_bound = 0
    step = 50
    @apartments_median = @apartments_median.reduce({}) { |res, x|
      if current_bound <= x[0] && x[0] <= current_bound + step
        res[current_bound] = 0 if res[current_bound].nil?
        res[current_bound] += x[1]
      else
        current_bound += step
        res[current_bound] = 0 if res[current_bound].nil?
        res[current_bound] += x[1]
      end
      res
    }

    @apartments_number_by_type = Apartment.where(apart_type: ['1_room','2_rooms']).group(:apart_type).order('apart_type').count
    total = {}
    @apartments_number_by_day = Apartment.where(apart_type: ['1_room','2_rooms']).joins(:prices)
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
