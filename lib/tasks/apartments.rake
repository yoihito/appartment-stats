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

end
