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

    @apartments_price_delta_by_day = @apartments_price_by_day.map { |type|
      {
        name: type[:name],
        data: type[:data].to_a.sort.reduce([]) { |res,val|
          if res.empty?
            res.push(val)
          else
            res[-1][1] = val[1] - res[-1][1]
            res.push(val)
          end
          res
        }.slice(0..-2)
      }
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
