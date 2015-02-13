namespace :apartments do
  desc "Loads all apartments"
  task load: :environment do
    ApartmentsLoader.load_apartments
    puts "#{Time.now} - success"
  end

end
