class RemoveApartmentDuplicates < ActiveRecord::Migration
  class Apartment < ActiveRecord::Base
  end
  def change
    Apartment.find_each do |a|
      apartments = Apartment.where(aid: a.aid).where('id>?',a.id)
      apartments.destroy_all
    end
  end
end
