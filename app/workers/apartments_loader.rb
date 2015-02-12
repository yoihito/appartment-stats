class ApartmentsLoader
  include HTTParty
  base_uri 'https://ak.api.onliner.by'

  def self.load_apartments
    current_size = 0
    page = 1
    response = self.get('/search/apartments', {query: {
      bounds: {
        lb: {
          lat: '53.50260276422582',
          long: '27.081546144531224'
          },
        rt: {
          lat: '54.29015300138517',
          long: '28.042849855468734'
        }
      }}})
    loop do
      parsed_response = JSON.parse(response.body)
      apartments = parsed_response['apartments']
      total = parsed_response['total']
      apartments.each do |x|
        hash = {
          aid: x['id'],
          url: x['url'],
          apart_type: x['rent_type'],
          address: x['location']['address'],
          longitude: x['location']['longitude'],
          latitude: x['location']['latitude'],
          price_usd: x['price']['usd'],
          price_byr: x['price']['byr']
        }
        Apartment.create(hash)
        current_size += 1
        puts hash[:aid]
      end
      puts current_size
      break if current_size == total
      page += 1
      response = self.get("/search/apartments", {query: {
        bounds: {
          lb: {
            lat: '53.50260276422582',
            long: '27.081546144531224'
          },
          rt: {
            lat: '54.29015300138517',
            long: '28.042849855468734'
          }
        }, page: page }})
    end
  end

end
