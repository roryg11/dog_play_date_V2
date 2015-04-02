class Park < ActiveRecord::Base
  geocoded_by :address_for_geocoding
  after_validation :geocode

  def address_for_geocoding
    if address.index("US") == nil && address.index("GB") == nil && address.index("ON") == nil
      index_of_address = -1
    elsif address.index("US") == nil && address.index("GB") == nil
      index_of_address = address.index("ON")
    elsif address.index("US") == nil
        index_of_address = address.index("GB") + 1
    else
      index_of_address = address.index("US") + 1
    end
    new_address = address[0..index_of_address]
  end
  
end
