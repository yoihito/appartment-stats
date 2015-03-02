class DistrictLoader
  def self.fetch(filename)
    desc = nil
    CSV.foreach(filename) do |row|
      unless desc
        desc = row
        next
      end
      row = desc.each.with_index.reduce({}) do |res, x|
        res[x[0]] = row[x[1]]
        res
      end
      country = Country.find_or_create_by(name: row['country'])
      city = City.where(country: country).where(name: row['city']).first_or_create
      district = District.where(city: city).where(name: row['cityAdministrativeRegion']).first_or_create
      district.geojson = row['geojson']
      if district.save
        puts "#{[country, city, district].reduce(''){|res,x| res+=x.name + ' '; res} } saved successful"
      else
        puts "#{[country, city, district].reduce(''){|res,x| res+=x.name + ' '; res} } not saved"
      end
    end
  end

  def self.clear
    District.destroy_all
  end
end
