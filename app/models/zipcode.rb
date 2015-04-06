class Zipcode < Filter

  def filter(dogs)
    location = content.split(", ")
    latitude = location[0].to_f
    upper_latitude = latitude + 0.4
    lower_latitude = latitude - 0.4
    longitude = location[1].to_f
    lower_longitude = longitude + 0.4
    upper_longitude = longitude - 0.4
    dogs = dogs
      .joins(:user)
      .where(
        users: {
          latitude: lower_latitude..upper_latitude,
          longitude: lower_longitude..upper_longitude
        }
      )
  end

end
