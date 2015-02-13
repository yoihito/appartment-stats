namespace :apartments do
  desc "Loads all apartments"
  task load: :environment do
    ApartmentsLoader.fetch(false)
    puts "#{Time.now} - success"
  end

  desc "Refresh prices"
  task refresh: :environment do
    ApartmentsLoader.fetch(true)
    puts "#{Time.now} - success"
  end

  task remove_duplicates: :environment do
    connection = ActiveRecord::Base.connection
    connection.execute(" DELETE FROM prices USING prices price2 WHERE prices.apartment_id = price2.apartment_id and date_trunc('day',prices.created_at)=date_trunc('day',price2.created_at) and prices.id < price2.id;")
  end

end
