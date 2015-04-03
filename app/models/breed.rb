class Breed < Filter
  def filter(dogs)
    dogs.where(breed: users_breed_filters.pluck(:content))
  end

  def users_breed_filters
    user.filters.where({type: "Breed"})
  end
end
