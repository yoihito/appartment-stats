namespace :districts do


  desc "Load districts from csv"
  task :load, [:filename] => :environment do |task,args|
    DistrictLoader.clear
    DistrictLoader.fetch(args.filename)
  end

end
