class Breed < Filter
  def filter(dogs)
    dogs.where('breed LIKE ?', "%#{content}%")
  end
end
