require 'date'
class ApartmentsLoader
  include HTTParty
  base_uri 'https://ak.api.onliner.by'

  def self.fetch(refresh)
    current_size = 0
    page = 1
    response = apartments_api
    loop do
      apartments = response['apartments']
      total = response['total']
      apartments.each do |x|
        create_apartment(hash_to_apartment_params(x), refresh)
        current_size += 1
      end
      break if current_size == total
      page += 1
      response = apartments_api(page)
    end
  end

  private

    def self.apartments_api(page = nil)
      query = {
        bounds: {
          lb: {
            lat: '53.50260276422582',
            long: '27.081546144531224'
          },
          rt: {
            lat: '54.29015300138517',
            long: '28.042849855468734'
          }
        }
      }
      query[:page] = page unless page.nil?
      JSON.parse(self.get('/search/apartments', {query: query}).body)
    end

    def self.hash_to_apartment_params(x)
      {
        apartment: {
          aid: x['id'],
          url: x['url'],
          apart_type: x['rent_type'],
          address: x['location']['address'],
          longitude: x['location']['longitude'],
          latitude: x['location']['latitude']
        },
        price: {
          price_usd: x['price']['usd'],
          price_byr: x['price']['byr'],
          apartment_id: x['id'],
          created_at: DateTime.current
        }
      }
    end

    def self.create_apartment(params, refresh)
      if refresh
        apartment = Apartment.find_by(aid: params[:apartment][:aid])
        if apartment.present?
          price = Price.where('date_trunc(\'day\' ,prices.created_at) = date_trunc(\'day\', date ?)',DateTime.current)
                       .where('apartment_id = ?', params[:apartment][:aid]).first
          if price.present?
            price.price_usd = params[:price][:price_usd]
            price.price_byr = params[:price][:price_byr]
            price.save
          else
            price = Price.new(params[:price])
            price.save
          end
        else
          ActiveRecord::Base.transaction do
            apartment = Apartment.new(params[:apartment])
            apartment.save
            price = Price.new(params[:price])
            price.save
          end
        end
      else
        apartment = Apartment.find_by(aid: params[:apartment][:aid])
        if apartment.present?
          price = Price.create(params[:price])
        else
          apartment = Apartment.new(params[:apartment])
          price = Price.new(params[:price])
          ActiveRecord::Base.transaction do
            price.save
            apartment.save
          end
        end
      end
    end

end

